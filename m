From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 20 Jul 2020 17:48:26 +0800
Subject: [LTP] [PATCH v2 4/7] net: Update README.md
In-Reply-To: <20200710172044.21592-5-pvorel@suse.cz>
References: <20200710172044.21592-1-pvorel@suse.cz>
 <20200710172044.21592-5-pvorel@suse.cz>
Message-ID: <5F15686A.1070605@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/7/11 1:20, Petr Vorel wrote:
> to previous commits (dropped rsh based testing and rsh, rcp, rlogin
> tests):
>
> * drop rlogin, rsh, rexec setup
> * rewrite ftp&  telnet setup
> * remove suggestion to run tests for 24 hrs (we lowered values in the
>    variables for stress testing in 52857efb7)
> * mention testcases/network/stress/README
> * update package names
> * fix formatting
>
> Signed-off-by: Petr Vorel<pvorel@suse.cz>
> ---
>   testcases/network/README.md | 96 ++++++++++++++-----------------------
>   1 file changed, 36 insertions(+), 60 deletions(-)
>
> diff --git a/testcases/network/README.md b/testcases/network/README.md
> index 3a9c98125..1c19a2c15 100644
> --- a/testcases/network/README.md
> +++ b/testcases/network/README.md
> @@ -1,91 +1,67 @@
>   # LTP Network Tests
>
> -## Pre-requisites
> -Enable all the networking services on test machine(s): rshd, nfsd, fingerd.
> -
>   ## Single Host Configuration
>
> -It is a default configuration ('RHOST' is not defined). LTP adds 'ltp_ns'
> -network namespace and auto-configure 'veth' pair according to LTP network
> -environment variables.
> +It is the default configuration (if the `RHOST` environment variable is not
> +defined). LTP adds `ltp_ns` network namespace and auto-configure `veth` pair
> +according to LTP network environment variables.
>
>   ## Two Host Configuration
>
> -This setup requires 'RHOST' environment variable to be set properly and
> -configured SSH or RSH (default) access to a remote host.
> -
> -The 'RHOST' variable name must be set to the hostname of the server
> -(test management link) and PASSWD should be set to the root password
> -of the remote server.
> -
> -In order to have RSH access:
> -* Edit the "/root/.rhosts" file. Please note that the file may not exist,
> -so you must create one if it does not. You must add the fully qualified
> -hostname of the machine you are testing on to this file. By adding the test
> -machine's hostname to this file, you will be allowing the machine to rsh to itself,
> -as root, without the requirement of a password.
> -
> -```sh
> -echo $client_hostname>>  /root/.rhosts
> -```
> -
> -You may need to re-label '.rhost' file to make sure rlogind will have access to it:
> -
> -```sh
> -/sbin/restorecon -v /root/.rhosts
> -```
> +This setup requires the `RHOST` environment variable to be set properly and
> +configured SSH access to a remote host.
>
> -* Add rlogin, rsh, rexec into /etc/securetty file:
> +The `RHOST` variable must be set to the hostname of the server (test management
> +link) and public key setup or login without password is required.
>
> -```sh
> -for i in rlogin rsh rexec; do echo $i>>  /etc/securetty; done
> -```
> +Some of the network stress tests which hasn't been ported to network API were
> +designed to be tested with `rsh` via `LTP_RSH` environment variable. Now it's
> +by default used `ssh`, for details see `testcases/network/stress/README`.
>
>   ## Server Services Configuration
>   Verify that the below daemon services are running. If not, please install
>   and start them:
> -rsh-server, telnet-server, finger-server, rdist, rsync, dhcp-server, http-server.
> +
> +dhcp-server, dnsmasq, http-server, nfs-kernel-server, rpcbind, rsync,
> +telnet-server, vsftpd
Hi Petr,

These package names are from Debian/Ubuntu, do we need to mention it?

>
>   Note: If any of the above daemon is not running on server, the test related to
>   that service running from client will fail.
>
> -### FTP setup
> -* In ?/etc/ftpusers? [or vi /etc/vsftpd.ftpusers], comment the line containing
> -?root? string. This file lists all those users who are not given access to do ftp
> +### FTP and telnet setup
> +Both tests require environment variables `RHOST` (remote machine), `RUSER`
> +(remote user) and `PASSWD` (remote password). NOTE: `RHOST` will imply two host
> +configuratioe for other tests.
> +
> +If `RHOST` is set to `root`, either of these steps is required:
> +
> +* In `/etc/ftpusers` (or `/etc/vsftpd.ftpusers`), comment the line containing
> +"root" string. This file lists all those users who are not given access to do ftp
>   on the current system.
Are this file from Debian/Ubuntu as well?

Other than this, it is good to me. :-)
Acked-by: Xiao Yang <yangx.jy@cn.fujitsu.com>

Thanks,
Xiao Yang
>
> -* If you don?t want to do the previous step, put following entry into /root/.netrc
> -machine<remote_server_name>  login root password<remote_root_password>.
> -Otherwise, ftp,rlogin&  telnet fails for ?root? user&  hence needs to be
> -executed using ?test? user to get successful results.
> +* If you don?t want to do the previous step, put following entry into `/root/.netrc`:
> +```
> +machine<remote_server_name>
> +login root
> +password<remote_root_password>
> +```
>
>   ## LTP setup
> -Install LTP testsuite. In case of two hosts configuration, make sure LTP is installed
> -on both client and server machines.
> -
> -Testcases and network tools must be in PATH, e.g.:
> +Install LTP testsuite. In case of two hosts configuration, LTP needs to be installed
> +and `LTPROOT` and `PATH` environment variables set on both client and server
> +machines (assuming using the default prefix `/opt/ltp`):
>
>   ```sh
> -export PATH=/opt/ltp/testcases/bin:/usr/bin:$PATH
> +export LTPROOT="/opt/ltp"; export PATH="$LTPROOT/testcases/bin:$PATH"
>   ```
> -Default values for all LTP network variables are set in testcases/lib/tst_net.sh.
> -If you need to override some parameters please export them before test run or
> -specify them when running ltp-pan or testscripts/network.sh.
> +Default values for all LTP network parameters are set in `testcases/lib/tst_net.sh`.
> +Network stress parameters are documented in `testcases/network/stress/README`.
>
>   ## Running the tests
> -To run the test type the following:
>
>   ```sh
>   TEST_VARS ./network.sh OPTIONS
>   ```
>   Where
> -* TEST_VARS - non-default network parameters (see testcases/lib/tst_net.sh), they
> -  could be exported before test run;
> -* OPTIONS - test group(s), use '-h' to see available ones.
> -
> -## Analyzing the results
> -Generally this test must be run more than 24 hours. When you want to stop the test
> -press CTRL+C to stop ./network.sh.
> -
> -Search failed tests in LTP logfile using grep FAIL<logfile>. For any failures,
> -run the individual tests and then try to come to the conclusion.
> +* `TEST_VARS` - non-default network parameters
> +* `OPTIONS` - test group(s), use `-h` to see available ones.



