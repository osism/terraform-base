retryable_errors = [
    "(?s).*Error waiting for instance.*",
    "(?s).*Gateway Timeout.*",
    "(?s).*Quota exceeded for resources.*",
    "(?s).*TLS handshake timeout.*",
    "(?s).*The backend server is unreachable.*",
    "(?s).*operation timed out.*",
]
