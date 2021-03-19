From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Mar 2021 12:17:17 +0800
Subject: [LTP] [PATCH v2 1/2] doc: Document test tags
In-Reply-To: <20210318181641.2062-2-pvorel@suse.cz>
References: <20210318181641.2062-1-pvorel@suse.cz>
 <20210318181641.2062-2-pvorel@suse.cz>
Message-ID: <CAEemH2cGPW5KkS2rzU7PcZrLQaF9=O88n-rtOaHtHFoZaCYOSQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Petr Vorel <pvorel@suse.cz> wrote:

+Glibc git commit in a regression test for a glibc bug:
> +[source,c]
>
> +-------------------------------------------------------------------------------
> +struct tst_test test = {
> +       ...
> +       .tags = (const struct tst_tag[]) {
> +               {"glibc-git", "574500a108be"},
> +               {}
> +       }
> +};
>
> +-------------------------------------------------------------------------------
> +
> +[source,c]
>
> +-------------------------------------------------------------------------------
> +struct tst_test test = {
> +       ...
> +       .tags = (const struct tst_tag[]) {
> +               {"glibc-git", "574500a108be"},
> +               {}
> +       }
> +};
>

I go through many times for the above two structures, but am not see any
difference:).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210319/7ce81cd2/attachment-0001.htm>
