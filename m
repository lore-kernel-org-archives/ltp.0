From: Li Wang <liwang@redhat.com>
Date: Thu, 29 Jul 2021 15:27:24 +0800
Subject: [LTP] [PATCH] mbind01: accept MPOL_LOCAL when passing empty set
 for MPOL_PREFERRED
In-Reply-To: <3d693985aafc13fba1cd7c4fa807bbbddd015c7b.1627303875.git.jstancek@redhat.com>
References: <3d693985aafc13fba1cd7c4fa807bbbddd015c7b.1627303875.git.jstancek@redhat.com>
Message-ID: <CAEemH2fR-2pF5WpvgEQrNRVHJKYekXPwe72_KmQy4Bvh+NRs6Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jul 26, 2021 at 8:53 PM Jan Stancek <jstancek@redhat.com> wrote:

> When empty set is passed to MPOL_PREFERRED, memory is allocated
> on the node of the CPU that triggered the allocation.
>
> After kernel commit:
>   7858d7bca7fb ("mm/mempolicy: don't handle MPOL_LOCAL like a fake
> MPOL_PREFERRED policy")
> kernel returns stored policy as MPOL_LOCAL.
>

As the MPOL_LOCAL has been setup as a real policy, I'm wondering should we
add more tests for it in the next? e.g.

--- a/testcases/kernel/syscalls/mbind/mbind01.c
+++ b/testcases/kernel/syscalls/mbind/mbind01.c
@@ -47,6 +47,19 @@ struct test_case {
 };

 static struct test_case tcase[] = {
+       {
+               POLICY_DESC(MPOL_LOCAL),
+               .ret = 0,
+               .err = 0,
+               .test = test_none,
+               .exp_nodemask = &empty_nodemask,
+       },
+       {
+               POLICY_DESC_TEXT(MPOL_LOCAL, "target exists"),
+               .ret = -1,
+               .err = EINVAL,
+               .test = test_default,
+       },
        {
                POLICY_DESC(MPOL_DEFAULT),
                .ret = 0,



>
> Per mhocko@suse.com in
> https://lists.linux.it/pipermail/ltp/2021-June/023037.html
>   Strictly speaking this is breaking user interface but I am wondering
>   whether this really matter or is completely unexpected ... I would
>   be inclined to keep this inconsistency and see whether anybody
>   actually complains and have a relevant use for this behavior.
>
> Modify the test to accept either MPOL_PREFERRED or MPOL_LOCAL.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>

But anyway, this patch makes sense!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210729/e122676e/attachment.htm>
