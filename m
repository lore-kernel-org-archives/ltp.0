From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 23 Oct 2019 10:11:47 +0200
Subject: [LTP] Bug report in read_all.c
In-Reply-To: <382857de8dca46e996b06ceb482cb911@apsanexr02f.ap.qualcomm.com>
References: <0641c15377874db893088e4f65102ec6@aptaiexm02f.ap.qualcomm.com>
 <20191022121222.GA15798@rei>
 <382857de8dca46e996b06ceb482cb911@apsanexr02f.ap.qualcomm.com>
Message-ID: <87d0enop8c.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Xiang Li <lixian@qti.qualcomm.com> writes:

> Hi,
>
> Thanks for Richard's suggestion. I've put it in the patch.
> Please check the attached patch file for review.

Thanks, LGTM.

However please do not send patches as attachments; we like to respond
with review comments inline.

>
> Regards,
> Xiang
>
>
> -----Original Message-----
> From: Cyril Hrubis <chrubis@suse.cz> 
> Sent: Tuesday, October 22, 2019 8:12 PM
> To: Xiang Li <lixian@qti.qualcomm.com>
> Cc: ltp@lists.linux.it
> Subject: [EXT] Re: [LTP] Bug report in read_all.c
>
> Hi!
>> Modifying i + 1 to (i + 1) % QUEUE_SIZE at the source code Line#123 can easily fix it.
>> This bug is not triggered on every machine because the files are different between target machine.
>> Adjust the length of the QUEUE_SIZE will help you reproduce this bug.
>
> Can you send a patch that I can apply (ideally with the suggestion from Ritchie as well)?


-- 
Thank you,
Richard.
