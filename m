From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 17 Mar 2021 07:13:19 +0100
Subject: [LTP] [PATCH] open_posix: Remove hardcoded /tmp
In-Reply-To: <CAEemH2dxiFi_6VUOpyaufkOecE8TCi-m8bVT=xY9GREzOfKW-A@mail.gmail.com>
References: <20210316130036.1838169-1-lkml@jv-coder.de>
 <CAEemH2dxiFi_6VUOpyaufkOecE8TCi-m8bVT=xY9GREzOfKW-A@mail.gmail.com>
Message-ID: <4e99e625-07f1-e0c1-ab23-30f0ee8e59ef@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
> It'd be great if a?passing string end?with the suffix "_", be used to 
> clearly distinguish the PID number.
>
> Something like:
> LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_1_1_");
>
> This comment applies to all of the changing files in this patch, or we 
> can modify it in the macro prototype.
Is this really of any use? I was also thinking about removing the prefix 
part of the filename completely.
I just decided to keep it, so files, that are not deleted automatically 
can be identified as belonging to the test.
If I would implement this, then only in the macro definition.

J?rg
