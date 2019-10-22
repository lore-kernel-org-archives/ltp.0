From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Oct 2019 14:12:22 +0200
Subject: [LTP] Bug report in read_all.c
In-Reply-To: <0641c15377874db893088e4f65102ec6@aptaiexm02f.ap.qualcomm.com>
References: <0641c15377874db893088e4f65102ec6@aptaiexm02f.ap.qualcomm.com>
Message-ID: <20191022121222.GA15798@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Modifying i + 1 to (i + 1) % QUEUE_SIZE at the source code Line#123 can easily fix it.
> This bug is not triggered on every machine because the files are different between target machine.
> Adjust the length of the QUEUE_SIZE will help you reproduce this bug.

Can you send a patch that I can apply (ideally with the suggestion from
Ritchie as well)?

-- 
Cyril Hrubis
chrubis@suse.cz
