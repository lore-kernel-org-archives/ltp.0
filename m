From: Cui Bixuan <cuibixuan@huawei.com>
Date: Sat, 17 Dec 2016 11:06:12 +0800
Subject: [LTP] [PATCH v2] Fix mistake in strcmp() for skipping in
 aarch64. And there is the same error in aarch64be, so add it.
In-Reply-To: <20161216125835.12024-1-the_hoang0709@yahoo.com>
References: <20161216125835.12024-1-the_hoang0709@yahoo.com>
Message-ID: <5854ABA4.9090007@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2016/12/16 20:58, the_hoang0709@yahoo.com wrote:
> 
> Signed-off-by: Vertigo <the_hoang0709@yahoo.com>
> ---
>  testcases/kernel/mem/tunable/max_map_count.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
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
git send-email --to ltp@lists.linux.it $your_patch  or as a attachment.

Thanks,
Cui Bixuan
> 
> 
> 

