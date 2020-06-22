From: Petr Vorel <petr.vorel@suse.com>
Date: Mon, 22 Jun 2020 09:09:08 +0200
Subject: [LTP] [RESENT PATCH 2/5] net: Update README.md
In-Reply-To: <20200622070911.16123-1-petr.vorel@suse.com>
References: <20200622070911.16123-1-petr.vorel@suse.com>
Message-ID: <20200622070911.16123-3-petr.vorel@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Petr Vorel <pvorel@suse.cz>

* to previous commit (dropped rsh based testing)
* fix formatting
* remove suggestion to run tests for 24 hrs (we lower variables for
  stress testing in the past)
* update package names
* mention testcases/network/stress/README

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/README.md | 73 +++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/testcases/network/README.md b/testcases/network/README.md
index 3a9c98125..a7eb40974 100644
--- a/testcases/network/README.md
+++ b/testcases/network/README.md
@@ -1,25 +1,25 @@
 # LTP Network Tests
 
-## Pre-requisites
-Enable all the networking services on test machine(s): rshd, nfsd, fingerd.
-
 ## Single Host Configuration
 
-It is a default configuration ('RHOST' is not defined). LTP adds 'ltp_ns'
-network namespace and auto-configure 'veth' pair according to LTP network
-environment variables.
+It is a default configuration (if the `RHOST` environment variable is not
+defined). LTP adds `ltp_ns` network namespace and auto-configure `veth` pair
+according to LTP network environment variables.
 
 ## Two Host Configuration
 
-This setup requires 'RHOST' environment variable to be set properly and
-configured SSH or RSH (default) access to a remote host.
+This setup requires the `RHOST` environment variable to be set properly and
+configured SSH access to a remote host.
 
 The 'RHOST' variable name must be set to the hostname of the server
-(test management link) and PASSWD should be set to the root password
+(test management link) and `PASSWD` should be set to the root password
 of the remote server.
 
-In order to have RSH access:
-* Edit the "/root/.rhosts" file. Please note that the file may not exist,
+Some of the network stress tests hasn't been ported to network API and still
+use `rsh` via `LTP_RSH` environment variable. To workaround this is best to set
+it to SSH, in order to run these tests with RSH following setup is needed:
+
+* Edit the `/root/.rhosts` file. Please note that the file may not exist,
 so you must create one if it does not. You must add the fully qualified
 hostname of the machine you are testing on to this file. By adding the test
 machine's hostname to this file, you will be allowing the machine to rsh to itself,
@@ -29,13 +29,13 @@ as root, without the requirement of a password.
 echo $client_hostname >> /root/.rhosts
 ```
 
-You may need to re-label '.rhost' file to make sure rlogind will have access to it:
+You may need to re-label `.rhost` file to make sure rlogind will have access to it:
 
 ```sh
 /sbin/restorecon -v /root/.rhosts
 ```
 
-* Add rlogin, rsh, rexec into /etc/securetty file:
+* Add rlogin, rsh, rexec into `/etc/securetty` file:
 
 ```sh
 for i in rlogin rsh rexec; do echo $i >> /etc/securetty; done
@@ -44,48 +44,43 @@ for i in rlogin rsh rexec; do echo $i >> /etc/securetty; done
 ## Server Services Configuration
 Verify that the below daemon services are running. If not, please install
 and start them:
-rsh-server, telnet-server, finger-server, rdist, rsync, dhcp-server, http-server.
+dhcp-server, dnsmasq, http-server, nfs-kernel-server, rpcbind, rsync, vsftpd
+
+RSH based testing requires also:
+rsh-server, telnet-server, finger-server, rdist
 
 Note: If any of the above daemon is not running on server, the test related to
 that service running from client will fail.
 
 ### FTP setup
-* In ?/etc/ftpusers? [or vi /etc/vsftpd.ftpusers], comment the line containing
-?root? string. This file lists all those users who are not given access to do ftp
+* In `/etc/ftpusers` (or `/etc/vsftpd.ftpusers`), comment the line containing
+"root" string. This file lists all those users who are not given access to do ftp
 on the current system.
 
-* If you don?t want to do the previous step, put following entry into /root/.netrc
-machine <remote_server_name> login root password <remote_root_password>.
-Otherwise, ftp,rlogin & telnet fails for ?root? user & hence needs to be
-executed using ?test? user to get successful results.
+* If you don?t want to do the previous step, put following entry into `/root/.netrc`:
+```
+machine <remote_server_name>
+login root
+password <remote_root_password>
+```
+Otherwise, `ftp`, `rlogin` and `telnet` tests fails for `root` user.
 
 ## LTP setup
-Install LTP testsuite. In case of two hosts configuration, make sure LTP is installed
-on both client and server machines.
-
-Testcases and network tools must be in PATH, e.g.:
+Install LTP testsuite. In case of two hosts configuration, LTP needs to be installed
+and `LTPROOT` and `PATH` environment variables set on both client and server
+machines (assuming using the default prefix `/opt/ltp`):
 
 ```sh
-export PATH=/opt/ltp/testcases/bin:/usr/bin:$PATH
+export LTPROOT="/opt/ltp"; export PATH="$LTPROOT/testcases/bin:$PATH"
 ```
-Default values for all LTP network variables are set in testcases/lib/tst_net.sh.
-If you need to override some parameters please export them before test run or
-specify them when running ltp-pan or testscripts/network.sh.
+Default values for all LTP network parameters are set in `testcases/lib/tst_net.sh`.
+Network stress parameters are documented in `testcases/network/stress/README`.
 
 ## Running the tests
-To run the test type the following:
 
 ```sh
 TEST_VARS ./network.sh OPTIONS
 ```
 Where
-* TEST_VARS - non-default network parameters (see testcases/lib/tst_net.sh), they
-  could be exported before test run;
-* OPTIONS - test group(s), use '-h' to see available ones.
-
-## Analyzing the results
-Generally this test must be run more than 24 hours. When you want to stop the test
-press CTRL+C to stop ./network.sh.
-
-Search failed tests in LTP logfile using grep FAIL <logfile>. For any failures,
-run the individual tests and then try to come to the conclusion.
+* TEST_VARS - non-default network parameters
+* OPTIONS - test group(s), use `-h` to see available ones.
-- 
2.27.0

