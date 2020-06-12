# helper function to skip tests if we don't have the 'tensorflow' module
skip_if_no_tf <- function() {
  have_tf <- reticulate::py_module_available("tensorflow")
  have_keras <- reticulate::py_module_available("keras")

  if (!as.logical(have_tf * have_keras)) {
    skip("TensorFlow and Keras not available for testing")
  }
}

test_that("Prediction function works", {
  skip_if_no_tf()
  expect_equal(
    deepredeff::predict_effector(
      input = system.file("extdata/example/fungi_sample.fasta", package = "deepredeff"),
      model = "fungi"
    ) %>%
      class() %>%
      .[[1]],
    "tbl_deepredeff"
  )
})