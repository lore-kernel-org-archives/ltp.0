Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1YQDmr-0006nG-Kl
	for ltp-list@lists.sourceforge.net; Tue, 24 Feb 2015 11:36:25 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YQDmq-0001EJ-Bg
	for ltp-list@lists.sourceforge.net; Tue, 24 Feb 2015 11:36:25 +0000
Message-ID: <54EC622A.7040106@redhat.com>
Date: Tue, 24 Feb 2015 12:36:10 +0100
From: Jiri Jaburek <jjaburek@redhat.com>
MIME-Version: 1.0
References: <1424766459-22439-1-git-send-email-weijg.fnst@cn.fujitsu.com>
	<1424766459-22439-2-git-send-email-weijg.fnst@cn.fujitsu.com>
In-Reply-To: <1424766459-22439-2-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] lib/tst_virt.c: distinguish between KVM and
 QEMU
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
To: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hello and thanks for the patch. Aside from indent issues (please use
tabs, Linux kernel style), I have some comments/questions:

On 02/24/2015 09:27 AM, Wei,Jiangang wrote:
> KVM guest is on top of QEMU, It's necessary that figure out
> the difference between the two.
> 
> Signed-off-by: Wei,Jiangang <weijg.fnst@cn.fujitsu.com>
> ---
>  lib/tst_virt.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/lib/tst_virt.c b/lib/tst_virt.c
> index eb3b487..1d9960e 100644
> --- a/lib/tst_virt.c
> +++ b/lib/tst_virt.c
> @@ -100,14 +100,24 @@ static int is_kvm(void)
>  	FILE *cpuinfo;
>  	char line[64];
>  	int found;
> +    char sig[SIG_MAX_LEN];
>  
> -	/* this doesn't work with custom -cpu values, since there's
> -	 * no easy, reasonable or reliable way to work around those */

When writing this, I was well aware of virt-what, which is exactly
why I wrote that comment the way I did - the code used by virt-what
is not easy, reliable or (IMO) reasonable to copy/paste into LTP.
Specifically with kvm, the KVMKVMKVM detection used to fail (IIRC)
with some specific hosts and qemu versions. It can also be easily
bypassed with -cpu host,kvm=off (which doesn't disable kvm accel).

>  	cpuinfo = SAFE_FOPEN(NULL, "/proc/cpuinfo", "r");
>  	found = 0;
>  	while (fgets(line, sizeof(line), cpuinfo) != NULL) {
>  		if (strstr(line, "QEMU Virtual CPU")) {
> -			found = 1;
> +            /*
> +             * Is it an KVM(on top of QEMU) or Only a QEMU?
> +             */

Well, yes, I'm aware that "KVM" is really just QEMU + accel, which
is why my original series actually had VIRT_QEMU instead of VIRT_KVM,
but then it was pointed out to me that VIRT_KVM would make sense to
most people not knowledgeable enough in this area.

I'm not against renaming it, but I'm a bit baffled by the separation.

> +            if (cpu_sign(&sig[0]) == 0) {
> +                if (strcmp(sig, "KVMKVMKVM") == 0) {
> +                    found = 1;
> +                } else {
> +                    // QEMU Guest

This leads me to ask why did you create the patches - why should the
default QEMU with TCG be any different w.r.t. the only test that
currently uses the tst_is_virt() function?

Again, I'm not against renaming VIRT_KVM to VIRT_QEMU as it would be
technically more correct, but why separate accel=kvm from accel=tcg?
What about accel=xen?

> +                }
> +            } else {
> +                found = 1;
> +            }
>  			break;
>  		}
>  	}
> 

Thanks,
Jiri


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
