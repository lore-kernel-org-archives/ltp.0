From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 20 Nov 2017 12:53:28 +0100
Subject: [LTP] [PATCH] syscall/read: add new testcase for read
In-Reply-To: <20171109092906.15715-1-lucas@opentech.at>
References: <20171109092906.15715-1-lucas@opentech.at>
Message-ID: <87po8di2tj.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Lucas,

Lucas Boehm writes:

>  Check the return value of read
>  1. Count bytes are read from the current file
>  2. Current offset is modified by lseek()
>  3. Count bytes are read from the current file
>
> Signed-off-by: Lucas Boehm <lucas@opentech.at>

The test lseek01 already uses seek before performing a read and checks
that the correct data was read.

-- 
Thank you,
Richard.
