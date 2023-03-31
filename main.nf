#!/usr/bin/env nextflow

// Process exit code
params.exit = 0
// Comma-separated durations in ISO-8601 format
params.durations = 'PT10S,PT15S'

process SLEEP_SOME {
  maxForks 1

  input:
  val duration

  script:
  """
  echo "Sleeping for ${duration.toString()}"
  sleep ${duration.toSeconds()}s
  exit ${params.exit}
  """
}

workflow {
  def durations = params.durations.tokenize(',').collect { java.time.Duration.parse(it.trim()) }
  channel.of(*durations) | SLEEP_SOME
}
