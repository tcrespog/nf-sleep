#!/usr/bin/env nextflow

params.exit = 0
// Comma-separated durations in ISO-8601 format
params.durations = 'PT10S,PT15S'

process SLEEP_SOME {
  machineType 'bar'
  maxForks 1

  input:
  val x

  script:
  """
  echo "Sleeping for $x seconds"
  sleep ${x}s
  exit ${params.exit}
  """
}

workflow {
  def durationsInSeconds = params.durations.tokenize(',').collect { java.time.Duration.parse(it.trim()).toSeconds() }
  channel.of(*durationsInSeconds) | SLEEP_SOME
}
