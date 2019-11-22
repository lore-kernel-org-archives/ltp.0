From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 22 Nov 2019 14:40:50 +0300
Subject: [LTP] [PATCH v2] lib/tst_net.sh: use SO_BINDTODEVICE in
 tst_netload()
In-Reply-To: <20191121174405.GA16389@dell5510>
References: <20191118104238.15044-1-alexey.kodanev@oracle.com>
 <20191121174405.GA16389@dell5510>
Message-ID: <43b42a21-aa98-fb52-9627-ba9e1826c74b@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 21.11.2019 20:44, Petr Vorel wrote:
> Hi Alexey,
> 
>> Since we have the information about the device, enable the
>> auto usage of the option, when starting netstress.
> 
>> It can be disabled with TST_NETLOAD_BINDTODEVICE=0 even if
>> '-D' option is passed to tst_netload().
> 
>> Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> nit: I'd use empty string instead of zero.
> testcases/lib/tst_net.sh
> -export TST_NETLOAD_BINDTODEVICE="${TST_NETLOAD_BINDTODEVICE:-1}"
> +export TST_NETLOAD_BINDTODEVICE="${TST_NETLOAD_BINDTODEVICE-1}"
> 
> testcases/network/mpls/mpls_lib.sh
> -TST_NETLOAD_BINDTODEVICE=0
> +TST_NETLOAD_BINDTODEVICE=

Hi Petr,

Changed the patch as you suggested and applied. Thanks for review!
