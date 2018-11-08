From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 8 Nov 2018 15:34:49 +0300
Subject: [LTP] [PATCH 4/6] network/mpls02: new test with lwtunnel
In-Reply-To: <20181107173615.GA12378@dell5510>
References: <1540818202-11247-1-git-send-email-alexey.kodanev@oracle.com>
 <1540818202-11247-5-git-send-email-alexey.kodanev@oracle.com>
 <20181102200207.GA17405@dell5510>
 <14316198-1a4b-ad70-5ff3-295b75f5faf9@oracle.com>
 <20181107173615.GA12378@dell5510>
Message-ID: <855bab25-b1db-87a9-fd0e-3576ce2d8427@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
On 11/07/2018 08:36 PM, Petr Vorel wrote:
> Hi Alexey,
> 
>>>> +	ROD modprobe mpls_router
>>>> +	ROD modprobe mpls_iptunnel
>>>> +	ROD modprobe mpls_gso
>>> Maybe just?
>>> ROD modprobe mpls_gso $TST_NEEDS_DRIVERS
> 
>> OK, and it will need the '-a' option.
> I wonder if we want to have a simple helper in tst_net.sh for loading modules on
> both sides, similar to tst_set_sysctl and tst_net_driver (from my pull request):
> 
> tst_net_driver()
> {
> 	ROD modprobe -a $@
> 	tst_rhost_run -c "modprobe -a $@"
> }
> 

Sure or even more generic, for any commands?
