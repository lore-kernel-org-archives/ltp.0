From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 28 Oct 2019 15:47:58 +0800
Subject: [LTP] [PATCH] syscalls/copy_file_range02: skip new error tests
 if cross-fs isn't supported
In-Reply-To: <20191025083738.GA13022@x230>
References: <1571968780-4810-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191025083738.GA13022@x230>
Message-ID: <202a3595-fd14-3a6c-ea02-8ba20aee9223@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



on 2019/10/25 16:37, Petr Vorel wrote:
> Hi Xu,
> 
>> We should not skip the whole error test if cross-fs isn't support because
>> old errors should be tested on all version. Even we use .mount_device = 1
>> and .mntpoint = MNTPOINT, the src and dest file are still in tmp directory
>> instead of mntpoint.
> 
>> ps: I doubt whether we should skip new error test because it indeed exposed this
>> unreasonable copy_file_range behavior of the user.
> 
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> 
> LGTM, but I'd like to have Amir's review/ack.
Hi Petr

Now, I think it can be merged if you don't have other doubt.

Thanks
Yang Xu
> 
> Kind regards,
> Petr
> 
> 


