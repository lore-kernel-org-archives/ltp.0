Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1M8OmC-0002Kf-Vv
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 01:14:52 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M8OmA-0002WL-OY
	for ltp-list@lists.sourceforge.net; Mon, 25 May 2009 01:14:52 +0000
Date: Mon, 25 May 2009 02:50:29 +0200
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
Content-Type: multipart/mixed; boundary=----------THEpx2cUs6kzBzcG2Wy5uB
MIME-Version: 1.0
References: <4A0A0116.8030604@web.de>
	<1242371868.7224.14.camel@subratamodak.linux.ibm.com>
	<1242647987.5161.13.camel@subratamodak.linux.ibm.com>
	<1242975136.8760.11.camel@subratamodak.linux.ibm.com>
Message-ID: <op.uugnafyfu2flwt@debian>
In-Reply-To: <1242975136.8760.11.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] Add an autoconf test for	presence
 oftaskstats.freepages_count
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

------------THEpx2cUs6kzBzcG2Wy5uB
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-2
Content-Transfer-Encoding: 7bit

On Fri, 22 May 2009 08:52:16 +0200, Subrata Modak  
<subrata@linux.vnet.ibm.com> wrote:

> Jiri,
>
> Any plans to resend this ?

Yes. Sorry, I oversaw this.

Regards
     Jiri Palecek
>
> On Mon, 2009-05-18 at 17:29 +0530, Subrata Modak wrote:
>> On Fri, 2009-05-15 at 12:47 +0530, Subrata Modak wrote:
>> > On Wed, 2009-05-13 at 01:07 +0200, Jiri Palecek wrote:
>> > > Also, use it in getdelays.c to prevent compilation failures
>> > >
>> > > Hello,
>> > >
>> > > I've found that ltp didn't compile on Debian because of old kernel  
>> headers,
>> > > which contain taskstats struct without some of the needed fields.  
>> This autoconf
>> > > test detects it and disables the code that would otherwise break.
>> > >
>> > > Regards
>> > >      Jiri Palecek
>> > >
>> > > Signed-off-by: Jiri Palecek <jpalecek@web.de>
>> >
>> > Same here:
>> >
>> > ERROR: patch seems to be corrupt (line wrapped?)
>> > #132: FILE: configure.ac:24:
>> > diff --git a/include/config.h.default b/include/config.h.default
>> > total: 1 errors, 0 warnings, 83 lines checked
>> >
>> > and
>> >
>> > patching file configure.ac
>> > patch: **** malformed patch at line 132: diff --git
>> > a/include/config.h.default b/include/config.h.default
>> >
>>
>> How about resending this Patch as well ?
>>
>> Regards--
>> Subrata
>>
>> > Regards--
>> > Subrata
>> >
>> > > ---
>> > >   configure.ac                                    |    1 +
>> > >   include/config.h.default                        |    2 +
>> > >   m4/ltp-taskstats.m4                             |   38  
>> +++++++++++++++++++++++
>> > >   testcases/kernel/controllers/cgroup/getdelays.c |   15 ++++++---
>> > >   4 files changed, 51 insertions(+), 5 deletions(-)
>> > >   create mode 100644 m4/ltp-taskstats.m4
>> > >
>> > > diff --git a/configure.ac b/configure.ac
>> > > index c534c97..9fc1696 100644
>> > > --- a/configure.ac
>> > > +++ b/configure.ac
>> > > @@ -20,5 +20,6 @@ LTP_CHECK_SYSCALL_MODIFY_LDT
>> > >   LTP_CHECK_SYSCALL_SIGNALFD
>> > >   LTP_CHECK_SELINUX
>> > >   LTP_CHECK_CRYPTO
>> > > +LTP_CHECK_TASKSTATS
>> > >    AC_OUTPUT
>> > > diff --git a/include/config.h.default b/include/config.h.default
>> > > index 9125d85..b9a6731 100644
>> > > --- a/include/config.h.default
>> > > +++ b/include/config.h.default
>> > > @@ -14,3 +14,5 @@
>> > >    /* ifaddrs.h is in glibc-2.3+ */
>> > >   #define HAVE_IFADDRS_H 1
>> > > +
>> > > +#define HAVE_TASKSTATS_FREEPAGES_COUNT 1
>> > > diff --git a/m4/ltp-taskstats.m4 b/m4/ltp-taskstats.m4
>> > > new file mode 100644
>> > > index 0000000..54da783
>> > > --- /dev/null
>> > > +++ b/m4/ltp-taskstats.m4
>> > > @@ -0,0 +1,38 @@
>> > > +dnl
>> > > +dnl Copyright (c) Jiri Palecek 2009
>> > > +dnl
>> > > +dnl This program is free software;  you can redistribute it and/or  
>> modify
>> > > +dnl it under the terms of the GNU General Public License as  
>> published by
>> > > +dnl the Free Software Foundation; either version 2 of the License,  
>> or
>> > > +dnl (at your option) any later version.
>> > > +dnl
>> > > +dnl This program is distributed in the hope that it will be useful,
>> > > +dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> > > +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> > > +dnl the GNU General Public License for more details.
>> > > +dnl
>> > > +dnl You should have received a copy of the GNU General Public  
>> License
>> > > +dnl along with this program;  if not, write to the Free Software
>> > > +dnl Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  
>> 02111-1307 USA
>> > > +dnl
>> > > +
>> > > +
>> > > +AC_DEFUN([LTP_CHECK_TASKSTATS],
>> > > +_LTP_CHECK_TASKSTATS_FREEPAGES
>> > > +)dnl
>> > > +
>> > > +dnl _LTP_CHECK_TASKSTATS_FREEPAGES
>> > > +dnl ----------------------------------------
>> > > +dnl
>> > > +dnl Check for taskstat.freepages_* members, introduced to the  
>> kernel
>> > > +dnl in commit 016ae219 in July 2008
>> > > +dnl
>> > > +
>> > > +AC_DEFUN([_LTP_CHECK_TASKSTATS_FREEPAGES],
>> > > +[dnl
>> > > +AC_CHECK_MEMBERS([struct taskstats.freepages_count],[],[],[dnl
>> > > +#include <linux/types.h>
>> > > +#include <linux/taskstats.h>
>> > > +])
>> > > +]dnl
>> > > +)dnl
>> > > diff --git a/testcases/kernel/controllers/cgroup/getdelays.c
>> > > b/testcases/kernel/controllers/cgroup/getdelays.c
>> > > index 13f7b3a..9fe2831 100644
>> > > --- a/testcases/kernel/controllers/cgroup/getdelays.c
>> > > +++ b/testcases/kernel/controllers/cgroup/getdelays.c
>> > > @@ -199,8 +199,10 @@ void print_delayacct(struct taskstats *t)
>> > >   	       "SWAP  %15s%15s\n"
>> > >   	       "      %15llu%15llu\n"
>> > >   	       "RECLAIM  %12s%15s\n"
>> > > -	       "      %15llu%15llu\n",
>> > > -	       "count", "real total", "virtual total", "delay total",
>> > > +#ifdef HAVE_TASKSTATS_FREEPAGES_COUNT
>> > > +	       "      %15llu%15llu\n"
>> > > +#endif
>> > > +	       , "count", "real total", "virtual total", "delay total",
>> > >   	       (unsigned long long)t->cpu_count,
>> > >   	       (unsigned long long)t->cpu_run_real_total,
>> > >   	       (unsigned long long)t->cpu_run_virtual_total,
>> > > @@ -211,9 +213,12 @@ void print_delayacct(struct taskstats *t)
>> > >   	       "count", "delay total",
>> > >   	       (unsigned long long)t->swapin_count,
>> > >   	       (unsigned long long)t->swapin_delay_total,
>> > > -	       "count", "delay total",
>> > > -	       (unsigned long long)t->freepages_count,
>> > > -	       (unsigned long long)t->freepages_delay_total);
>> > > +	       "count", "delay total"
>> > > +#ifdef HAVE_TASKSTATS_FREEPAGES_COUNT
>> > > +	       , (unsigned long long)t->freepages_count,
>> > > +	       (unsigned long long)t->freepages_delay_total
>> > > +#endif
>> > > +	       );
>> > >   }
>> > >    void task_context_switch_counts(struct taskstats *t)
>> > > --
>> > > 1.6.2
>> > >
>> > >
>> > >  
>> ------------------------------------------------------------------------------
>> > > The NEW KODAK i700 Series Scanners deliver under ANY circumstances!  
>> Your
>> > > production scanning environment may not be a perfect world - but  
>> thanks to
>> > > Kodak, there's a perfect scanner to get the job done! With the NEW  
>> KODAK i700
>> > > Series Scanner you'll get full speed at 300 dpi even with all image
>> > > processing features enabled. http://p.sf.net/sfu/kodak-com
>> > > _______________________________________________
>> > > Ltp-list mailing list
>> > > Ltp-list@lists.sourceforge.net
>> > > https://lists.sourceforge.net/lists/listinfo/ltp-list
>> >
>> >
>> >  
>> ------------------------------------------------------------------------------
>> > Crystal Reports - New Free Runtime and 30 Day Trial
>> > Check out the new simplified licensing option that enables
>> > unlimited royalty-free distribution of the report engine
>> > for externally facing server and web deployment.
>> > http://p.sf.net/sfu/businessobjects
>> > _______________________________________________
>> > Ltp-list mailing list
>> > Ltp-list@lists.sourceforge.net
>> > https://lists.sourceforge.net/lists/listinfo/ltp-list
>>
>>
>> ------------------------------------------------------------------------------
>> Crystal Reports - New Free Runtime and 30 Day Trial
>> Check out the new simplified licensing option that enables
>> unlimited royalty-free distribution of the report engine
>> for externally facing server and web deployment.
>> http://p.sf.net/sfu/businessobjects
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>



-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
------------THEpx2cUs6kzBzcG2Wy5uB
Content-Disposition: attachment;
	filename*0="0016-Add-an-autoconf-test-for-presence-o"; 
	filename*1="f-taskstats.freep.patch"
Content-Type: application/octet-stream;
	name*0="0016-Add-an-autoconf-test-for-presence-o"; 
	name*1="f-taskstats.freep.patch"
Content-Transfer-Encoding: Base64

RnJvbSBhZTg1YTE1NWE4NjUxNDgwNGI1NzFjMGUxODRiZmJlZTY2Y2QwZWU5IE1v
biBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKaXJpIFBhbGVjZWsgPGpwYWxl
Y2VrQHdlYi5kZT4KRGF0ZTogVGh1LCA3IE1heSAyMDA5IDEzOjQ4OjA2ICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gQWRkIGFuIGF1dG9jb25mIHRlc3QgZm9yIHByZXNl
bmNlIG9mIHRhc2tzdGF0cy5mcmVlcGFnZXNfY291bnQKQ2M6ICJsdHAtbGlzdEBs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQiIDxsdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3Jn
ZS5uZXQ+CgogQWxzbywgdXNlIGl0IGluIGdldGRlbGF5cy5jIHRvIHByZXZlbnQg
Y29tcGlsYXRpb24gZmFpbHVyZXMKClNpZ25lZC1vZmYtYnk6IEppcmkgUGFsZWNl
ayA8anBhbGVjZWtAd2ViLmRlPgotLS0KIGNvbmZpZ3VyZS5hYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSArCiBpbmNsdWRlL2NvbmZp
Zy5oLmRlZmF1bHQgICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDIgKwogbTQv
bHRwLXRhc2tzdGF0cy5tNCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
IDM4ICsrKysrKysrKysrKysrKysrKysrKysrCiB0ZXN0Y2FzZXMva2VybmVsL2Nv
bnRyb2xsZXJzL2Nncm91cC9nZXRkZWxheXMuYyB8ICAgMTUgKysrKysrLS0tCiA0
IGZpbGVzIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
CiBjcmVhdGUgbW9kZSAxMDA2NDQgbTQvbHRwLXRhc2tzdGF0cy5tNAoKZGlmZiAt
LWdpdCBhL2NvbmZpZ3VyZS5hYyBiL2NvbmZpZ3VyZS5hYwppbmRleCBjNTM0Yzk3
Li45ZmMxNjk2IDEwMDY0NAotLS0gYS9jb25maWd1cmUuYWMKKysrIGIvY29uZmln
dXJlLmFjCkBAIC0yMCw1ICsyMCw2IEBAIExUUF9DSEVDS19TWVNDQUxMX01PRElG
WV9MRFQKIExUUF9DSEVDS19TWVNDQUxMX1NJR05BTEZECiBMVFBfQ0hFQ0tfU0VM
SU5VWAogTFRQX0NIRUNLX0NSWVBUTworTFRQX0NIRUNLX1RBU0tTVEFUUwogCiBB
Q19PVVRQVVQKZGlmZiAtLWdpdCBhL2luY2x1ZGUvY29uZmlnLmguZGVmYXVsdCBi
L2luY2x1ZGUvY29uZmlnLmguZGVmYXVsdAppbmRleCA5MTI1ZDg1Li5iOWE2NzMx
IDEwMDY0NAotLS0gYS9pbmNsdWRlL2NvbmZpZy5oLmRlZmF1bHQKKysrIGIvaW5j
bHVkZS9jb25maWcuaC5kZWZhdWx0CkBAIC0xNCwzICsxNCw1IEBACiAKIC8qIGlm
YWRkcnMuaCBpcyBpbiBnbGliYy0yLjMrICovCiAjZGVmaW5lIEhBVkVfSUZBRERS
U19IIDEKKworI2RlZmluZSBIQVZFX1RBU0tTVEFUU19GUkVFUEFHRVNfQ09VTlQg
MQpkaWZmIC0tZ2l0IGEvbTQvbHRwLXRhc2tzdGF0cy5tNCBiL200L2x0cC10YXNr
c3RhdHMubTQKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uNTRk
YTc4MwotLS0gL2Rldi9udWxsCisrKyBiL200L2x0cC10YXNrc3RhdHMubTQKQEAg
LTAsMCArMSwzOCBAQAorZG5sCitkbmwgQ29weXJpZ2h0IChjKSBKaXJpIFBhbGVj
ZWsgMjAwOQorZG5sCitkbmwgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7
ICB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CitkbmwgaXQg
dW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZSBhcyBwdWJsaXNoZWQgYnkKK2RubCB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0
aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9mIHRoZSBMaWNlbnNlLCBvcgorZG5sIChh
dCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCitkbmwKK2RubCBUaGlz
IHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxs
IGJlIHVzZWZ1bCwKK2RubCBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7ICB3aXRo
b3V0IGV2ZW4gdGhlIGltcGxpZWQgd2FycmFudHkgb2YKK2RubCBNRVJDSEFOVEFC
SUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUK
K2RubCB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUgZGV0
YWlscy4KK2RubAorZG5sIFlvdSBzaG91bGQgaGF2ZSByZWNlaXZlZCBhIGNvcHkg
b2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlCitkbmwgYWxvbmcgd2l0
aCB0aGlzIHByb2dyYW07ICBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3
YXJlCitkbmwgRm91bmRhdGlvbiwgSW5jLiwgNTkgVGVtcGxlIFBsYWNlLCBTdWl0
ZSAzMzAsIEJvc3RvbiwgTUEgMDIxMTEtMTMwNyBVU0EKK2RubAorCisKK0FDX0RF
RlVOKFtMVFBfQ0hFQ0tfVEFTS1NUQVRTXSwKK19MVFBfQ0hFQ0tfVEFTS1NUQVRT
X0ZSRUVQQUdFUworKWRubAorCitkbmwgX0xUUF9DSEVDS19UQVNLU1RBVFNfRlJF
RVBBR0VTCitkbmwgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQorZG5sCitkbmwgQ2hlY2sgZm9yIHRhc2tzdGF0LmZyZWVwYWdlc18qIG1l
bWJlcnMsIGludHJvZHVjZWQgdG8gdGhlIGtlcm5lbAorZG5sIGluIGNvbW1pdCAw
MTZhZTIxOSBpbiBKdWx5IDIwMDgKK2RubAorCitBQ19ERUZVTihbX0xUUF9DSEVD
S19UQVNLU1RBVFNfRlJFRVBBR0VTXSwKK1tkbmwKK0FDX0NIRUNLX01FTUJFUlMo
W3N0cnVjdCB0YXNrc3RhdHMuZnJlZXBhZ2VzX2NvdW50XSxbXSxbXSxbZG5sCisj
aW5jbHVkZSA8bGludXgvdHlwZXMuaD4KKyNpbmNsdWRlIDxsaW51eC90YXNrc3Rh
dHMuaD4KK10pCitdZG5sCispZG5sCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL2NvbnRyb2xsZXJzL2Nncm91cC9nZXRkZWxheXMuYyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvY29udHJvbGxlcnMvY2dyb3VwL2dldGRlbGF5cy5jCmluZGV4IDEzZjdi
M2EuLjlmZTI4MzEgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJv
bGxlcnMvY2dyb3VwL2dldGRlbGF5cy5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwv
Y29udHJvbGxlcnMvY2dyb3VwL2dldGRlbGF5cy5jCkBAIC0xOTksOCArMTk5LDEw
IEBAIHZvaWQgcHJpbnRfZGVsYXlhY2N0KHN0cnVjdCB0YXNrc3RhdHMgKnQpCiAJ
ICAgICAgICJTV0FQICAlMTVzJTE1c1xuIgogCSAgICAgICAiICAgICAgJTE1bGx1
JTE1bGx1XG4iCiAJICAgICAgICJSRUNMQUlNICAlMTJzJTE1c1xuIgotCSAgICAg
ICAiICAgICAgJTE1bGx1JTE1bGx1XG4iLAotCSAgICAgICAiY291bnQiLCAicmVh
bCB0b3RhbCIsICJ2aXJ0dWFsIHRvdGFsIiwgImRlbGF5IHRvdGFsIiwKKyNpZmRl
ZiBIQVZFX1RBU0tTVEFUU19GUkVFUEFHRVNfQ09VTlQKKwkgICAgICAgIiAgICAg
ICUxNWxsdSUxNWxsdVxuIgorI2VuZGlmCisJICAgICAgICwgImNvdW50IiwgInJl
YWwgdG90YWwiLCAidmlydHVhbCB0b3RhbCIsICJkZWxheSB0b3RhbCIsCiAJICAg
ICAgICh1bnNpZ25lZCBsb25nIGxvbmcpdC0+Y3B1X2NvdW50LAogCSAgICAgICAo
dW5zaWduZWQgbG9uZyBsb25nKXQtPmNwdV9ydW5fcmVhbF90b3RhbCwKIAkgICAg
ICAgKHVuc2lnbmVkIGxvbmcgbG9uZyl0LT5jcHVfcnVuX3ZpcnR1YWxfdG90YWws
CkBAIC0yMTEsOSArMjEzLDEyIEBAIHZvaWQgcHJpbnRfZGVsYXlhY2N0KHN0cnVj
dCB0YXNrc3RhdHMgKnQpCiAJICAgICAgICJjb3VudCIsICJkZWxheSB0b3RhbCIs
CiAJICAgICAgICh1bnNpZ25lZCBsb25nIGxvbmcpdC0+c3dhcGluX2NvdW50LAog
CSAgICAgICAodW5zaWduZWQgbG9uZyBsb25nKXQtPnN3YXBpbl9kZWxheV90b3Rh
bCwKLQkgICAgICAgImNvdW50IiwgImRlbGF5IHRvdGFsIiwKLQkgICAgICAgKHVu
c2lnbmVkIGxvbmcgbG9uZyl0LT5mcmVlcGFnZXNfY291bnQsCi0JICAgICAgICh1
bnNpZ25lZCBsb25nIGxvbmcpdC0+ZnJlZXBhZ2VzX2RlbGF5X3RvdGFsKTsKKwkg
ICAgICAgImNvdW50IiwgImRlbGF5IHRvdGFsIgorI2lmZGVmIEhBVkVfVEFTS1NU
QVRTX0ZSRUVQQUdFU19DT1VOVAorCSAgICAgICAsICh1bnNpZ25lZCBsb25nIGxv
bmcpdC0+ZnJlZXBhZ2VzX2NvdW50LAorCSAgICAgICAodW5zaWduZWQgbG9uZyBs
b25nKXQtPmZyZWVwYWdlc19kZWxheV90b3RhbAorI2VuZGlmCisJICAgICAgICk7
CiB9CiAKIHZvaWQgdGFza19jb250ZXh0X3N3aXRjaF9jb3VudHMoc3RydWN0IHRh
c2tzdGF0cyAqdCkKLS0gCjEuNi4yCgo=

------------THEpx2cUs6kzBzcG2Wy5uB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
------------THEpx2cUs6kzBzcG2Wy5uB
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------------THEpx2cUs6kzBzcG2Wy5uB--


