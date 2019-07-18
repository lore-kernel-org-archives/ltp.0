From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 18 Jul 2019 15:30:19 +0800
Subject: [LTP] [PATCH v5 1/3] lib: alter find_free_loopdev()
In-Reply-To: <20190717105418.GB14596@rei>
References: <20190711125108.GB8709@rei>
 <1563356676-2384-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAOQ4uxiV_weQXVnDn0vFq5exk=Z_F=70Lk1D+783fOV=hsf_6A@mail.gmail.com>
 <5D2EF9D1.3020102@cn.fujitsu.com> <20190717105418.GB14596@rei>
Message-ID: <5D30200B.4050306@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Hi!
>>> Another option is to leave this function internal and export a wrapper
>>> for the exact needed functionality:
>>>
>>> /* Just find a free minor number */
>>> int tst_find_free_loopdev(void)
>>> {
>>>           return find_free_loopdev(NULL, 0);
>>> }
>>>
>>> I don't mind wither way.
>> Hi Amir
>>
>> The second way looks better for me.  But I also want to hear the idea of cyril.
> Well I wanted to keep the path exposed to user in a case that there
> would be a test that would need more than one device. But it's not like
> we cannot change the API later when it's actually needed.
>
Hi Cyril


Ok. I will use the first way to expose the path. Also on my copy_file_range02, I will directly use
path filled with this api because it doesn't change libary state.

If you think this pathset is no problem, I will send v6 patch.


Thanks
Yang Xu



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190718/e647c11e/attachment-0001.htm>
