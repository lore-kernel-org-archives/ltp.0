From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Nov 2019 13:45:35 +0800
Subject: [LTP] [PATCH] fallocate05: increase FALLOCATE_SIZE
In-Reply-To: <202fcb5a-c110-abdf-c305-7a0f5b6c1efc@suse.cz>
References: <d8ad4bab26557fdf70e7ebc3f771bbb37ae889d7.1574093242.git.jstancek@redhat.com>
 <202fcb5a-c110-abdf-c305-7a0f5b6c1efc@suse.cz>
Message-ID: <CAEemH2cDVF6Hv=KUmFo8eF2fdgvQqdMTmwZPnwRRffhDTFa-tw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 19, 2019 at 12:19 AM Martin Doucha <mdoucha@suse.cz> wrote:

> On 11/18/19 5:08 PM, Jan Stancek wrote:
> > write() returning ENOSPC doesn't guarantee that filesystem after
> > some internal book-keeping, flushing, finishing transactions, etc.
> > won't still find some extra space.
> >
> > Increase FALLOCATE_SIZE to minimize chance of hitting sporadic
> > failures when that happens.
>
> We're planning to rewrite fallocate05 this week and FALLOCATE_SIZE will
> be removed entirely. The test must use a multiple of the real file
> system block size, otherwise it'll test different things on different
> platforms.
>

Sounds good. Thanks!

But it'd be better to merge Jan's patch first because there will still need
time for new patch reviewing.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191119/2362b5a9/attachment.htm>
