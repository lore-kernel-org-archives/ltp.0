From: Li Wang <liwang@redhat.com>
Date: Thu, 26 Apr 2018 18:00:59 +0800
Subject: [LTP] LTP cve-2017-5754 test fails on kernel-v4.17-rc2
In-Reply-To: <CAEemH2enj4MUFRc03CLzuHzqJGJFESeQvj5oitZ2Am+Ww=jVYA@mail.gmail.com>
References: <CAEemH2enj4MUFRc03CLzuHzqJGJFESeQvj5oitZ2Am+Ww=jVYA@mail.gmail.com>
Message-ID: <CAEemH2dCNqG__gxwN_jdhjiC_SW_3ip1aDwr8LHLrBf65=jn6g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Thu, Apr 26, 2018 at 3:02 PM, Li Wang <liwang@redhat.com> wrote:

> Hi LKML & LTP,
>
> LTP/meltdown.c fails on upstream kernel-v4.17-rc2 with both kvm and
> bare-metal system. Please attention!!!
>

​The failure was only occurred on kvm system not include bare-matal. Sorry
for that.

After a simple discussion with Jan, we guess the reason is that commit
8c06c774 (x86/pti: Leave kernel text global for !PCID)​
involves new function pti_kernel_image_global_ok(void) which makes kernel
use global pages when pti_mode == PTI_AUTO,
then LTP meltdown.c obviously easy to read the linux_banner content there.

After rebooting kernel with parameter "pti=on", the FAIL is gone. So, from
the result, seems LTP/meltdown.c should be improved.

​Btw, I'm not very good at this, If anything I was wrong, pls feel free to
correct me.​


============
  391     * Global pages and PCIDs are both ways to make kernel TLB entries
   392     * live longer, reduce TLB misses and improve kernel performance.
   393     * But, leaving all kernel text Global makes it potentially
accessible
   394     * to Meltdown-style attacks which make it trivial to find
gadgets or
   395     * defeat KASLR.
   396     *
   397     * Only use global pages when it is really worth it.
   398     */
   399    static inline bool pti_kernel_image_global_ok(void)
   400    {
   401        /*
   402         * Systems with PCIDs get litlle benefit from global
   403         * kernel text and are not worth the downsides.
   404         */
   405        if (cpu_feature_enabled(X86_FEATURE_PCID))
   406            return false;
   407
   408        /*
   409         * Only do global kernel image for pti=auto.  Do the most
   410         * secure thing (not global) if pti=on specified.
   411         */
   412        if (pti_mode != PTI_AUTO)
   413            return false;
   414
   415        /*
   416         * K8 may not tolerate the cleared _PAGE_RW on the userspace
   417         * global kernel image pages.  Do the safe thing (disable
   418         * global kernel image).  This is unlikely to ever be
   419         * noticed because PTI is disabled by default on AMD CPUs.
   420         */
   421        if (boot_cpu_has(X86_FEATURE_K8))
   422            return false;
   423
   424        return true;
   425    }



-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180426/96b38afc/attachment.html>
