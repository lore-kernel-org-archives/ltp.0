From: Xiang Li <lixian@qti.qualcomm.com>
Date: Wed, 23 Oct 2019 03:23:42 +0000
Subject: [LTP] Bug report in read_all.c
In-Reply-To: <20191022121222.GA15798@rei>
References: <0641c15377874db893088e4f65102ec6@aptaiexm02f.ap.qualcomm.com>
 <20191022121222.GA15798@rei>
Message-ID: <382857de8dca46e996b06ceb482cb911@apsanexr02f.ap.qualcomm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Thanks for Richard's suggestion. I've put it in the patch.
Please check the attached patch file for review. 

Regards,
Xiang


-----Original Message-----
From: Cyril Hrubis <chrubis@suse.cz> 
Sent: Tuesday, October 22, 2019 8:12 PM
To: Xiang Li <lixian@qti.qualcomm.com>
Cc: ltp@lists.linux.it
Subject: [EXT] Re: [LTP] Bug report in read_all.c

Hi!
> Modifying i + 1 to (i + 1) % QUEUE_SIZE at the source code Line#123 can easily fix it.
> This bug is not triggered on every machine because the files are different between target machine.
> Adjust the length of the QUEUE_SIZE will help you reproduce this bug.

Can you send a patch that I can apply (ideally with the suggestion from Ritchie as well)?

--
Cyril Hrubis
chrubis@suse.cz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Fix-memory-read-overflow-when-a-full-file-path-store.patch
Type: application/octet-stream
Size: 1234 bytes
Desc: 0001-Fix-memory-read-overflow-when-a-full-file-path-store.patch
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191023/9572d1a1/attachment.obj>
