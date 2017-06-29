From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 29 Jun 2017 15:09:18 +0200
Subject: [LTP] [PATCH v2 1/4] syscalls/mq_timedreceive: Add check data
 returned from mq_timedreceive
In-Reply-To: <20170609191252.9870-1-pvorel@suse.cz>
References: <20170609191252.9870-1-pvorel@suse.cz>
Message-ID: <20170629130918.GA3233@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	for (j = 0; j < tc->len; j++) {
> +		if (rmsg[j] != smsg[j]) {
> +			tst_res(TFAIL | TTERRNO, "mq_timedreceive wrong data in loop %d returned %d, expected %d",
                                         ^
                                      I've removed the TTERRNO here and
				      from the previous message as well,
				      since that will always print
				      SUCCESS here anyway and pushed,
				      thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
