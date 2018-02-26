From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 26 Feb 2018 14:07:55 +0300
Subject: [LTP] about net_stress.ipsec_dccp fail
In-Reply-To: <40525c5e-f951-88c7-87cf-1b045227ca5e@cn.fujitsu.com>
References: <40525c5e-f951-88c7-87cf-1b045227ca5e@cn.fujitsu.com>
Message-ID: <4a180d1d-f537-12ac-3bdc-67d25af7784d@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On 02/24/2018 06:57 AM, sunlianwen wrote:
> Hi Alexey
> 
>    I have a problem consult with you about net_stress.ipsec_dccp. when execute net_stress.ipsec_dccp on RHEL7.5Beta,
> 
> dccp4_ipsec* / dccp6_ipsce* all faill and report the same error . the error info is "socket(10, 6, 33) failed: ESOCKTNOSUPPORT",
> 
> I debug this error, find this error happen  on create a ipv6 dccp  socket,but ipv6 dccp type socket is no support on RHEL7.5Beta.
> 
> so I want to know whether this error cause by RHEL7.5Beta system self no support or all socket no support ipv6 dccp type socket by no?


It's in the release notes, dccp module blacklisted in
/etc/modprobe.d/dccp-blacklist.conf

Not sure how to correctly end the test with TCONF if we don't
want to change default settings, or may be try to load it manually
inside netstress tool...

Anyway "modprobe dccp" before the test should make it work again.

Thanks,
Alexey
