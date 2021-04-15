From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Apr 2021 16:27:13 +0200
Subject: [LTP] [PATCH v3 1/2] splice02: Generate input in C
In-Reply-To: <YHhJdwbeUCz5sDfK@pevik>
References: <20210413043844.5612-1-pvorel@suse.cz> <YHhDurTlljhXAKL9@yuki>
 <YHhJdwbeUCz5sDfK@pevik>
Message-ID: <YHhNQSCotEieKcnx@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> LGTM, going to merge it with these changes (+ cleanup to_write)
> and your Reviewed-by: tags.
> Thanks a lot!

Maybe one more change: INT_MAX is a bit too much, it timeouts.
I'll use 262144 as max allowed -n (the default on intel - 2x max pipe size).

Kind regards,
Petr
