From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 31 Jul 2020 18:24:10 +0200
Subject: [LTP] [PATCH v3 2/2] net: Update network related docs
In-Reply-To: <20200731162410.2637-1-pvorel@suse.cz>
References: <20200731162410.2637-1-pvorel@suse.cz>
Message-ID: <20200731162410.2637-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* testcases/network/README.md
- drop rlogin, rsh, rexec setup (removed in previous commit "net: Remove
  rsh, rcp, rlogin tests")
- rewrite server side configuration (most of the services are started
  thus not needed to be running, improve ftp & telnet setup; add HTTP,
  NFS and TI-RPC / Sun RPC (glibc) setup)
- remove suggestion to run tests for 24 hrs (we lowered values in the
  variables for stress testing in 52857efb7)
- mention testcases/network/stress/README
- update package names
- fix formatting

* INSTALL
- move everything relevant to testcases/network/README.md (rpcbind).
- drop xinetd setup (only in.telnetd is tested nowadays and does not
  have to be running, just installed)
- drop /etc/securetty section (rlogin, rsh, rexec aren't used any more
  and ssh access IMHO does not require pts/[0-9])

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 INSTALL                     |  49 +---------------
 testcases/network/README.md | 113 +++++++++++++++++-------------------
 2 files changed, 54 insertions(+), 108 deletions(-)

diff --git a/INSTALL b/INSTALL
index 2056e8ea0..52d61101e 100644
--- a/INSTALL
+++ b/INSTALL
@@ -151,54 +151,7 @@ contributions are welcome.
    in the CD-ROM drive.  The corresponding tests will fail if either disk is
    missing.
 
-5. The network tests are executed by running the network.sh script. The network
-   tests require some configuration for them to work correctly:
-
-     i) First, there MUST be another test machine setup to act as the server
-	to these client side tests.  This machine MUST have the LTP installed
-	in the same exact location, i.e. if the client has /root/ltp, then the
-	server must have /root/ltp.  This is required because certain tests
-	expect to find server files in certain locations.  Make sure to compile
-	the LTP on this server machine also.
-
-    ii) Second, the server must be setup to allow the client to connect using
-	the "r" commands, such as rsh.  This is done by simply creating/editing
-	the ".rhosts" file under /root.  Place the hostname of the client
-	machine in this file to allow root to remotely connect without the use
-	of a password. If server has the PAM system security tool, you need
-	to add the following lines to /etc/securetty:
-		rlogin
-		rsh
-		rexec
-		pts/0
-		pts/1
-		  :
-		pts/9
-
-   iii) Next, certain services must be activated in order for certain tests to
-	execute.  The following services are activated via inetd/xinetd:
-		rlogind
-		ftpd
-		telnetd
-		echo (stream)
-		fingerd
-		rshd
-	 Also, because certain RPC programs are tested, the portmapper daemon
-	 (rpcbind, or portmap on old distributions) MUST be started, as well as NFS
-	 server AND lock services.
-
-    iv) Finally, before running the network.sh script, two variables must be
-	set: The "RHOST" variable should be set to the hostname of the server.
-	The "PASSWD" variable should be set to root's password on the server
-	machine. This is necessary for tests such as telnet01.sh and ftp01.sh.
-
-   You can now successfully execute the network.sh script.
-
-   You can run the test category which you are interested in, -h option shows
-   the list of the test category:
-       # ./network.sh -h
-
-   For more info about howto run network.sh see testcases/network/README.md.
+5. The network tests related installation see testcases/network/README.md.
 
 Cross compiling
 ---------------
diff --git a/testcases/network/README.md b/testcases/network/README.md
index e589adc64..34728fbeb 100644
--- a/testcases/network/README.md
+++ b/testcases/network/README.md
@@ -1,94 +1,87 @@
 # LTP Network Tests
 
-## Pre-requisites
-Enable all the networking services on test machine(s): rshd, nfsd, fingerd.
-
-Both single and two host configurations support debugging via
-`TST_NET_RHOST_RUN_DEBUG=1` environment variable.
-
 ## Single Host Configuration
 
-It is a default configuration ('RHOST' is not defined). LTP adds 'ltp_ns'
-network namespace and auto-configure 'veth' pair according to LTP network
-environment variables.
+It's the default configuration (if the `RHOST` environment variable is not
+defined). LTP adds `ltp_ns` network namespace and auto-configure `veth` pair
+according to LTP network environment variables.
 
 ## Two Host Configuration
 
-This setup requires 'RHOST' environment variable to be set properly and
-configured SSH or RSH (default) access to a remote host.
+This setup requires the `RHOST` environment variable to be set properly and
+configured SSH access to a remote host.
 
-The 'RHOST' variable name must be set to the hostname of the server
-(test management link) and PASSWD should be set to the root password
-of the remote server.
+The `RHOST` variable must be set to the hostname of the server (test management
+link) and public key setup or login without password is required.
 
-In order to have RSH access:
-* Edit the "/root/.rhosts" file. Please note that the file may not exist,
-so you must create one if it does not. You must add the fully qualified
-hostname of the machine you are testing on to this file. By adding the test
-machine's hostname to this file, you will be allowing the machine to rsh to itself,
-as root, without the requirement of a password.
+SSH server needs to be configured to allow root login and use Public Key
+Authentication (`PermitRootLogin yes` and `PubkeyAuthentication yes` in
+`/etc/ssh/sshd_config`).
 
-```sh
-echo $client_hostname >> /root/.rhosts
-```
+Some of the network stress tests which hasn't been ported to network API were
+designed to be tested with `rsh` via `LTP_RSH` environment variable. Now it's
+by default used `ssh`, for details see `testcases/network/stress/README`.
 
-You may need to re-label '.rhost' file to make sure rlogind will have access to it:
+## Server Services Configuration
+Tests have various external dependencies, exit with `TCONF` when not installed.
+Some tests require additional setup.
 
-```sh
-/sbin/restorecon -v /root/.rhosts
-```
+### FTP and telnet setup
+FTP stress tests and telnet server tests require environment variables `RHOST`
+(remote machine), `RUSER` (remote user) and `PASSWD` (remote password). NOTE:
+`RHOST` will imply two host configuration for other tests.
 
-* Add rlogin, rsh, rexec into /etc/securetty file:
+If `RHOST` is set to `root`, either of these steps is required:
 
-```sh
-for i in rlogin rsh rexec; do echo $i >> /etc/securetty; done
+* In `/etc/ftpusers` (or `/etc/vsftpd.ftpusers`), comment the line containing
+"root" string. This file lists all those users who are not given access to do ftp
+on the current system.
+
+* If you don?t want to do the previous step, put following entry into `/root/.netrc`:
+```
+machine <remote_server_name>
+login root
+password <remote_root_password>
 ```
 
-## Server Services Configuration
-Verify that the below daemon services are running. If not, please install
-and start them:
-rsh-server, telnet-server, finger-server, rdist, rsync, dhcp-server, http-server.
+### HTTP setup
+HTTP stress tests require configured and running web server (Apache2, Nginx, etc.).
 
-Note: If any of the above daemon is not running on server, the test related to
-that service running from client will fail.
+### NFS setup
+NFS tests require running NFS server must be running, enable and start `nfs-server.service`
+(Debian/Ubuntu and openSUSE/SLES: `nfs-kernel-server` package, others `nfs-server` package).
 
-### FTP setup
-* In ?/etc/ftpusers? [or vi /etc/vsftpd.ftpusers], comment the line containing
-?root? string. This file lists all those users who are not given access to do ftp
-on the current system.
+There is no detection whether service is running, test will simply fail without warning.
 
-* If you don?t want to do the previous step, put following entry into /root/.netrc
-machine <remote_server_name> login root password <remote_root_password>.
-Otherwise, ftp,rlogin & telnet fails for ?root? user & hence needs to be
-executed using ?test? user to get successful results.
+### TI-RPC / Sun RPC setup
+TI-RPC (or glibc legacy Sun RPC) tests require running rpcbind (or portmap on
+old distributions), enable and start `rpcbind.service`.
 
 ## LTP setup
-Install LTP testsuite. In case of two hosts configuration, make sure LTP is installed
-on both client and server machines.
+Install LTP testsuite (see INSTALL). In case of two hosts configuration, LTP
+needs to be installed the same exact location and `LTPROOT` and `PATH`
+environment variables set on *both* client and server machines. This is
+required because some tests expect to find server files in certain locations.
 
-Testcases and network tools must be in PATH, e.g.:
+Example for the default prefix `/opt/ltp`:
 
 ```sh
-export PATH=/opt/ltp/testcases/bin:/usr/bin:$PATH
+export LTPROOT="/opt/ltp"; export PATH="$LTPROOT/testcases/bin:$PATH"
 ```
-Default values for all LTP network variables are set in testcases/lib/tst_net.sh.
-If you need to override some parameters please export them before test run or
-specify them when running ltp-pan or testscripts/network.sh.
 
 ## Running the tests
-To run the test type the following:
+The network tests are executed by running the network.sh script:
 
 ```sh
 TEST_VARS ./network.sh OPTIONS
 ```
 Where
-* TEST_VARS - non-default network parameters (see testcases/lib/tst_net.sh), they
-  could be exported before test run;
-* OPTIONS - test group(s), use '-h' to see available ones.
+* `TEST_VARS` - non-default network parameters
+* `OPTIONS` - test group(s), use `-h` to see available ones.
 
-## Analyzing the results
-Generally this test must be run more than 24 hours. When you want to stop the test
-press CTRL+C to stop ./network.sh.
+Default values for all LTP network parameters are set in `testcases/lib/tst_net.sh`.
+Network stress parameters are documented in `testcases/network/stress/README`.
 
-Search failed tests in LTP logfile using grep FAIL <logfile>. For any failures,
-run the individual tests and then try to come to the conclusion.
+## Debugging
+Both single and two host configurations support debugging via
+`TST_NET_RHOST_RUN_DEBUG=1` environment variable.
-- 
2.27.0

