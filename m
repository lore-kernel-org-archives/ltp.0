From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 21 Oct 2020 17:36:43 +0100
Subject: [LTP] [PATCH 2/3] lib: Add generic boolean expression parser
 and eval
In-Reply-To: <871rhrwnb7.fsf@suse.de>
References: <20201020100910.10828-1-chrubis@suse.cz>
 <20201020100910.10828-3-chrubis@suse.cz> <871rhrwnb7.fsf@suse.de>
Message-ID: <87y2jzv8mc.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

> Cyril Hrubis <chrubis@suse.cz> writes:
>> +
>> +enum tst_op {
>> +	TST_OP_NOT,
>> +	TST_OP_AND,
>> +	TST_OP_OR,
>> +	TST_OP_VAR,
>> +	/* Used only internally */
>> +	TST_OP_LPAR,
>> +	TST_OP_RPAR,
>> +};
>> +
>> +struct tst_expr {
>> +	enum tst_op op;
>> +	struct tst_expr *next;
>> +	char *err;
>> +	void *priv;
>
> I'm not sure if this is used?

I see it, ignore this.
-- 
Thank you,
Richard.
