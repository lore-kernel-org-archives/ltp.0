From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Mar 2021 12:34:06 +0800
Subject: [LTP] [PATCH v2 2/2] doc: Add Maintainer Patch Review Checklist
In-Reply-To: <20210318181641.2062-3-pvorel@suse.cz>
References: <20210318181641.2062-1-pvorel@suse.cz>
 <20210318181641.2062-3-pvorel@suse.cz>
Message-ID: <CAEemH2fUGFY6YH=m4SfGpJ_nbYWJmUK1_-mLK8n74zM_WNFLng@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Mar 19, 2021 at 2:17 AM Petr Vorel <pvorel@suse.cz> wrote:

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  doc/maintainer-patch-review-checklist.txt | 53 +++++++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 doc/maintainer-patch-review-checklist.txt
>
> diff --git a/doc/maintainer-patch-review-checklist.txt
> b/doc/maintainer-patch-review-checklist.txt
> new file mode 100644
> index 000000000..2587287aa
> --- /dev/null
> +++ b/doc/maintainer-patch-review-checklist.txt
> @@ -0,0 +1,53 @@
> +# Maintainer Patch Review Checklist
> +
> +Patchset should be tested locally and ideally also in maintainer's fork in
> +https://travis-ci.org/[Travis CI].
> +
> +NOTE: Travis does only build testing, passing the CI means only that the
> +      test compiles fine on variety of different distributions and
> +      releases.
> +
> +The test should be executed at least once locally and should PASS as well.
> +
> +Commit messages should have
> +
> +* Author's `Signed-off-by` tag
> +* Committer's `Reviewed-by` or `Signed-off-by` tag
>

Or adding `Acked-by:` also acceptable?

I'm not sure what's the difference between Acked-by and Reviewed-by,
but personally feel the Acked-by has more confidence in the reviewing.

In my mind,

`Acked-by` means:
code review OK, compiled OK, executed OK, has confidence it OK for all
arches

`Reviewed-by` means:
code review OK, compiled and executed OK just locally or optional, still room
for improvement/discussion

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210319/11b13771/attachment.htm>
