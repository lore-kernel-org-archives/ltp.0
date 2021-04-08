From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Apr 2021 10:48:17 +0200
Subject: [LTP] [PATCH v3 1/4] lib: Add proper filesystem skiplist
In-Reply-To: <CAEemH2frh1iyW9SrVJkwXT9nrHt1C+WUmQUcNb=mCota9_xKAA@mail.gmail.com>
References: <20210317105318.32017-1-chrubis@suse.cz>
 <20210317105318.32017-2-chrubis@suse.cz>
 <CAEemH2frh1iyW9SrVJkwXT9nrHt1C+WUmQUcNb=mCota9_xKAA@mail.gmail.com>
Message-ID: <YG7DUS1lObVjsrBo@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Do you think it necessary to rename 'enum tst_fs_type' to distinguish with
> 'fs_type'?
> 
> As it is quite similar to the 'fs_type*' series function and structure,
> that might mess up
> the code (we even have the same name function: tst_fs_type). So, I'd like
> to suggest
> use 'enum tst_fs_status' or 'enum tst_fs_item', or anything else.

What about enum 'tst_fs_impl' as for filesystem implementation?

-- 
Cyril Hrubis
chrubis@suse.cz
