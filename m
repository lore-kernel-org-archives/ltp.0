From: Hoang Nguyen <the_hoang0709@yahoo.com>
Date: Sat, 17 Dec 2016 04:34:15 +0000 (UTC)
Subject: [LTP] [PATCH v2] Fix mistake in strcmp() for skipping in
 aarch64. And there is the same error in aarch64be, so add it.
In-Reply-To: <5854ABA4.9090007@huawei.com>
References: <20161216125835.12024-1-the_hoang0709@yahoo.com>
 <5854ABA4.9090007@huawei.com>
Message-ID: <389215298.4676169.1481949255172@mail.yahoo.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi,
I've added the commit message last time (same as your way), but not know why the patch is created, it's disappeared.(I may put the messages in the wrong way, a blank line need after the first line comment? )
Sorry for did not check the patch file.
I've sent it again.
Thanks a lot for your help.
Br,H


      From: Cui Bixuan <cuibixuan@huawei.com>
 To: ltp@lists.linux.it 
 Sent: Saturday, 17 December 2016, 10:06
 Subject: Re: [LTP] [PATCH v2] Fix mistake in strcmp() for skipping in aarch64. And there is the same error in aarch64be, so add it.
   
On 2016/12/16 20:58, the_hoang0709@yahoo.com wrote:
> 
> Signed-off-by: Vertigo <the_hoang0709@yahoo.com>
> ---
>  testcases/kernel/mem/tunable/max_map_count.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
It looks well, but there are no message and Signed-off-by in your patch;

Maybe you can do:
git add $file;
git commit;
and write it:

[title](such as 'Fix mistake in strcmp() for skipping in aarch64')

You can write something for this commit, about the error.

Signed-off-by: Vertigo <the_hoang0709@yahoo.com>

# Please enter the commit message for your changes. Lines starting
# with '#' will be ignored, and an empty message aborts the commit.
# On branch master
...

Then 'git format-patch -1' can get your patch;
git send-email --to ltp@lists.linux.it $your_patch  or as a attachment.

Thanks,
Cui Bixuan
> 
> 
> 


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp


   
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161217/a4574127/attachment-0001.html>
