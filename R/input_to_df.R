#' FASTA to dataframe
#'
#' @param fasta_path Path to FASTA file.
#'
#' @return Data frame.
#' @export
fasta_to_df <- function(fasta_path) {
  data_list <- seqinr::read.fasta(fasta_path)

  data <- data_list %>%
    purrr::map(
      .f = function(x) {
        data.frame(
          c(
            x %>%
              attributes() %>%
              unlist(),
            x %>%
              paste0(collapse = "") %>%
              toupper() %>%
              `names<-`("sequence")
          ) %>%
            dplyr::bind_rows()
        )
      }
    ) %>%
    purrr::reduce(dplyr::bind_rows)

  return(data)
}

#' AAStringset class to dataframe
#'
#' @param aas AAStringset class object.
#'
#' @return Data frame.
#' @export
aasset_to_df <- function(aas) {
  data <- data.frame(
    names = names(aas),
    seq = as.character(aas),
    row.names = NULL
  )

  return(data)
}

#' AAString class to dataframe
#'
#' @param aas AAString class object.
#'
#' @return Data frame.
#' @export
aas_to_df <- function(aas) {
  aas <- Biostrings::AAStringSet(aas)
  data <- data.frame(
    names = as.character(aas),
    seq = as.character(aas),
    row.names = NULL
  )

  return(data)
}