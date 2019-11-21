From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Nov 2019 18:44:05 +0100
Subject: [LTP] [PATCH v2] lib/tst_net.sh: use SO_BINDTODEVICE in
 tst_netload()
In-Reply-To: <20191118104238.15044-1-alexey.kodanev@oracle.com>
References: <20191118104238.15044-1-alexey.kodanev@oracle.com>
Message-ID: <20191121174405.GA16389@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

> Since we have the information about the device, enable the
> auto usage of the option, when starting netstress.

> It can be disabled with TST_NETLOAD_BINDTODEVICE=0 even if
> '-D' option is passed to tst_netload().

> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

nit: I'd use empty string instead of zero.
testcases/lib/tst_net.sh
-export TST_NETLOAD_BINDTODEVICE="${TST_NETLOAD_BINDTODEVICE:-1}"
+export TST_NETLOAD_BINDTODEVICE="${TST_NETLOAD_BINDTODEVICE-1}"

testcases/network/mpls/mpls_lib.sh
-TST_NETLOAD_BINDTODEVICE=0
+TST_NETLOAD_BINDTODEVICE=

Kind regards,
Petr
