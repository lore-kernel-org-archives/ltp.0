From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 6 Jun 2017 15:58:08 +0200
Subject: [LTP] [PATCH 1/3] syscalls/mq_timedreceive: Add check data
 returned from mq_timedreceive
In-Reply-To: <20170605200549.3832-1-pvorel@suse.cz>
References: <20170605200549.3832-1-pvorel@suse.cz>
Message-ID: <20170606135808.GE5208@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	for (j = 0; j < tc->len; j++) {
> +		if (rmsg[j] != smsg[j]) {
> +			tst_res(TFAIL | TTERRNO, "mq_timedreceive wrong data in loop %d returned %d, expected %d",

Let's keep the messages short and to the point, something as:

			tst_res(TFAIL,
				"mq_timedreceive(): wrong data %i at %u, expected %i",
				rmsg[j], j, smsg[j]);

And also we should drop the TTERRNO since it's uninitialized in this
case.


Otherwise it's fine.

-- 
Cyril Hrubis
chrubis@suse.cz
