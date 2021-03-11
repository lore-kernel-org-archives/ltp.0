From: Li Wang <liwang@redhat.com>
Date: Thu, 11 Mar 2021 20:46:11 +0800
Subject: [LTP] [PATCH v2 0/4] Add proper filesystem skiplist
In-Reply-To: <20210311105509.2701-1-chrubis@suse.cz>
References: <20210311105509.2701-1-chrubis@suse.cz>
Message-ID: <CAEemH2ed2nX6NotjzZZ+UQRsaEo-xCqx698vWODvh39dXr6A4A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Mar 11, 2021 at 6:53 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> This adds a proper .skip_filesystems array to the tst_test structure and
> implements support for both test with .all_filesystems enabled and
> disabled.
>
> As a bonus point we get the list of filesystems that the test does not
> support exported to the metadata as well.
>
> Changes in v2:
>
> * Add docs (as Jan requested)
>
> * Move the skiplist detection from the is_supported_by_kernel()
>   to tst_fs_is_supported()
>   (as requested by Martin and Li)
>   (which also fixed the double message reported by Peter)
>
> * Fixed typos in tst_fs.h header (as requested by Peter)
>
> Cyril Hrubis (4):
>   lib: Add proper filesystem skiplist
>   lib: tst_fs_type change fs names to lowercase
>   lib: Apply the skip_filesystems to rest of test as well
>   doc: Update docs on filesystem detection
>

For series:
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210311/2b2fbea7/attachment.htm>
