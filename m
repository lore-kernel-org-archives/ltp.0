From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 23 Mar 2018 18:37:27 +0300
Subject: [LTP] [PATCH v2 0/2] sctp: add new regression test for CVE-2018-5803
Message-ID: <1521819449-27489-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* create lapi/sctp.h header and define SCTP_SOCKOPT_BINDX_ADD if
  there is no linux/sctp.h.

* add new test to network/sctp for over-sized SCTP chunk.

Alexey Kodanev (2):
  include/lapi: add sctp.h
  sctp: new regression test sctp_big_chunk for CVE-2018-5803

 configure.ac                            |    1 +
 include/lapi/sctp.h                     |   29 ++++++++
 include/lapi/socket.h                   |    4 +
 runtest/cve                             |    2 +
 testcases/network/.gitignore            |    1 +
 testcases/network/sctp/Makefile         |    2 +-
 testcases/network/sctp/sctp_big_chunk.c |  121 +++++++++++++++++++++++++++++++
 7 files changed, 159 insertions(+), 1 deletions(-)
 create mode 100644 include/lapi/sctp.h
 create mode 100644 testcases/network/sctp/sctp_big_chunk.c

