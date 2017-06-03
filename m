From: Petr Vorel <pvorel@suse.cz>
Date: Sat,  3 Jun 2017 14:00:14 +0200
Subject: [LTP] [RFC PATCH v6 03/11] network/stress: Fix typo
In-Reply-To: <20170603120022.13415-1-pvorel@suse.cz>
References: <20170603120022.13415-1-pvorel@suse.cz>
Message-ID: <20170603120022.13415-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/README                  | 6 +++---
 testcases/network/stress/ns-tools/ns-tcpserver.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/network/stress/README b/testcases/network/stress/README
index fbfbc1cc0..c0d0ad374 100644
--- a/testcases/network/stress/README
+++ b/testcases/network/stress/README
@@ -23,7 +23,7 @@ control link is never changed.
 
 Test Links are the place where the stress tests run. For example, test packets
 flow those links. The number of test links must be at least 1. The setting of
-the interfaces connectted to the test links would be changed by the tests.
+the interfaces connected to the test links would be changed by the tests.
 Therefore, each test link should not belong to any external network. It is
 recommended to connect each pair of interfaces with the ether cross cables.
 
@@ -136,13 +136,13 @@ Required environment variables
 
  o LHOST_HWADDRS
    The blank-separated hardware address list of the interfaces which are
-   connectted to a test link at the local host.
+   connected to a test link at the local host.
    This value have to have at least one address. The sequence of the hardware
    address have to be same to the test link sequence.
 
  o RHOST_HWADDRS
    The blank-separated hardware address list of the interfaces which are
-   connectted to a test link at the remote host.
+   connected to a test link at the remote host.
    This value have to have at least one address. The sequence of the hardware
    address have to be same to the test link sequence.
 
diff --git a/testcases/network/stress/ns-tools/ns-tcpserver.c b/testcases/network/stress/ns-tools/ns-tcpserver.c
index 4ac51a9ee..bfbcc0d4e 100644
--- a/testcases/network/stress/ns-tools/ns-tcpserver.c
+++ b/testcases/network/stress/ns-tools/ns-tcpserver.c
@@ -276,7 +276,7 @@ void create_listen_socket(struct server_info *info_p)
  * Function: communicate_client()
  *
  * Descripton:
- *  Communicate with the connectted client.
+ *  Communicate with the connected client.
  *  Currently, this function sends tcp segment in the specified second
  *  or recevie SIGHUP
  *
-- 
2.12.2

