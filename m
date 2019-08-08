From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Aug 2019 17:13:44 +0800
Subject: [LTP] [RFC PATCH 1/9] lib: Add support for guarded buffers
In-Reply-To: <20190808090635.GA11500@rei.lan>
References: <20190801092616.30553-1-chrubis@suse.cz>
 <20190801092616.30553-2-chrubis@suse.cz>
 <871rxyd5tc.fsf@rpws.prws.suse.cz> <20190808090635.GA11500@rei.lan>
Message-ID: <CAEemH2fWSxuXegxGiKRWzpHLHQdgxTe_nHW+-0ezusJKNp4T7A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > This seems like debug info to me. Not really useful most of the time.
>
> Yes, this is a leftover.
>
> I do wonder if we should print a message first time the tst_alloc() is
> called so that it's clear that the test is using guarded buffers.

Sounds necessary. Or should we need a way for silent using?

-- 
Regards,
Li Wang
