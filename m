Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <weijg.fnst@cn.fujitsu.com>) id 1YQShU-0006qA-33
	for ltp-list@lists.sourceforge.net; Wed, 25 Feb 2015 03:31:52 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YQShR-0003yQ-SN
	for ltp-list@lists.sourceforge.net; Wed, 25 Feb 2015 03:31:52 +0000
From: "Wei, Jiangang" <weijg.fnst@cn.fujitsu.com>
Date: Wed, 25 Feb 2015 03:31:44 +0000
Message-ID: <BA9BBA9F6C9A254FBAE45927EF336E908D37F9@G08CNEXMBPEKD03.g08.fujitsu.local>
References: <1424766459-22439-1-git-send-email-weijg.fnst@cn.fujitsu.com>
	<1424766459-22439-2-git-send-email-weijg.fnst@cn.fujitsu.com>
	<54EC622A.7040106@redhat.com>
In-Reply-To: <54EC622A.7040106@redhat.com>
Content-Language: zh-CN
MIME-Version: 1.0
Subject: [LTP] =?utf-8?b?562U5aSNOiBbUEFUQ0ggMi8yXSBsaWIvdHN0X3ZpcnQuYzog?=
 =?utf-8?q?distinguish_between_KVM_and_QEMU?=
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jiri Jaburek <jjaburek@redhat.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi,

> Hello and thanks for the patch. Aside from indent issues (please use
> tabs, Linux kernel style), I have some comments/questions:
Thanks for your reminder.
I'll take care of it.

> On 02/24/2015 09:27 AM, Wei,Jiangang wrote:
> > KVM guest is on top of QEMU, It's necessary that figure out
> > the difference between the two.
> >
> > Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
> > ---
> >  lib/tst_virt.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/lib/tst_virt.c b/lib/tst_virt.c
> > index eb3b487..1d9960e 100644
> > --- a/lib/tst_virt.c
> > +++ b/lib/tst_virt.c
> > @@ -100,14 +100,24 @@ static int is_kvm(void)
> >  	FILE *cpuinfo;
> >  	char line[64];
> >  	int found;
> > +    char sig[SIG_MAX_LEN];
> >
> > -	/* this doesn't work with custom -cpu values, since there's
> > -	 * no easy, reasonable or reliable way to work around those */
> 
> When writing this, I was well aware of virt-what, which is exactly
> why I wrote that comment the way I did - the code used by virt-what
> is not easy, reliable or (IMO) reasonable to copy/paste into LTP.
> Specifically with kvm, the KVMKVMKVM detection used to fail (IIRC)
So far, I haven't met such an error.
Maybe it's depended on the different version.
In fact, The case of its' failure had been considered in this patch.
When cpu_sign() returns non-zero,
It will degenerate and determine the Guest Type by the original method,
Which just check the string ' QEMU Virtual CPU ' in /proc/cpuinfo.
As following,
if (cpu_sign(&sig[0]) == 0) {
   ...
} else {
	found = 1;
}

> with some specific hosts and qemu versions. It can also be easily
> bypassed with -cpu host,kvm=off (which doesn't disable kvm accel).
Indeed, I agree with you.

> 
> >  	cpuinfo = SAFE_FOPEN(NULL, "/proc/cpuinfo", "r");
> >  	found = 0;
> >  	while (fgets(line, sizeof(line), cpuinfo) != NULL) {
> >  		if (strstr(line, "QEMU Virtual CPU")) {
> > -			found = 1;
> > +            /*
> > +             * Is it an KVM(on top of QEMU) or Only a QEMU?
> > +             */
> 
> Well, yes, I'm aware that "KVM" is really just QEMU + accel, which
> is why my original series actually had VIRT_QEMU instead of VIRT_KVM,
> but then it was pointed out to me that VIRT_KVM would make sense to
> most people not knowledgeable enough in this area.
> 
> I'm not against renaming it, but I'm a bit baffled by the separation.
> 
> > +            if (cpu_sign(&sig[0]) == 0) {
> > +                if (strcmp(sig, "KVMKVMKVM") == 0) {
> > +                    found = 1;
> > +                } else {
> > +                    // QEMU Guest
> 
> This leads me to ask why did you create the patches - why should the
> default QEMU with TCG be any different w.r.t. the only test that
> currently uses the tst_is_virt() function?
> 
> Again, I'm not against renaming VIRT_KVM to VIRT_QEMU as it would be
> technically more correct, but why separate accel=kvm from accel=tcg?
> What about accel=xen?

Initially, I found that,
The function named is_kvm() is only can be applied to determine QEMU,
Which couldn't distinguish QEMU and QEMU-KVM.
So, I tried to make this function has the ability to determine 
the difference between the two.

The only test that uses the tst_is_virt() skips,
no matter what QEMU or QEMU-KVM.
My effort seems pointless.

For is_kvm and VIRT_KVM,
I still regard that its' name doesn't match its' content and function.
is_qemu() more reasonable.
If you don't mind,
I will push a new patch to improve it.

Thanks,
Wei

> > +                }
> > +            } else {
> > +                found = 1;
> > +            }
> >  			break;
> >  		}
> >  	}
> >
> 
> Thanks,
> Jiri

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
