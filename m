From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 21 Jul 2021 17:29:56 +0200
Subject: [LTP] [PATCH v4 1/5] libs/libltpnewipc/libnewipc.c: Add
 msg_do_reader/msg_do_writer function
In-Reply-To: <1615550541-21714-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20201111163114.GB23576@yuki.lan>
 <1615550541-21714-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <YPg9dN2GhnncVnQQ@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +void msg_do_reader(long key, int tid, long type, int child, int nreps)
> +{
> +	int i, size;
> +	int id;
> +	struct mbuffer buffer;
> +
> +	id = SAFE_MSGGET(key, 0);
> +	if (id != tid) {
> +		tst_brk(TFAIL,
> +			"Message queue mismatch in the reader of child group %d for message queue id %d ",
> +			child, id);
> +	}

Also looking at how these functions are used, we fork a child that calls
this function then wait it and ignore the exit value it does not make
sense to use tst_brk() here at all.

The tst_brk() is supposed to exit the whole test, including all
suprocesses but that does not work if we throw away the child return
value. This piece of code looks like we exit the whole test here, which
isn't simply true.

So either we should do tst_res(TFAIL, ...) followed by an exit(0) here,
or we should handle the return value in the parent. I.e. stop the test
if one of the children reported a failure.

> +	for (i = 0; i < nreps; i++) {
> +		memset(&buffer, 0, sizeof(buffer));
> +
> +		size = SAFE_MSGRCV(id, &buffer, 100, type, 0);
> +		if (buffer.type != type) {
> +			tst_brk(TFAIL,
> +				"Type mismatch in child %d, read #%d, for message got %ld, exected %ld",
> +				child, (i + 1), buffer.type, type);
> +		}
> +		if (buffer.data.len + 1 != size) {
> +			tst_brk(TFAIL,
> +				"Size mismatch in child %d, read #%d, for message got %d, expected %d",
> +				child, (i + 1), buffer.data.len + 1, size);
> +		}
> +		if (verify(buffer.data.pbytes, (key % 255), size - 1, child)) {
> +			tst_brk(TFAIL,
> +				"Verify failed in child %d read # = %d, key = %lx",
> +				child, (i + 1), key);
> +		}
> +		key++;
> +	}

It would also make sense to do exit(0); here so that we do not have to
repeat that in each test.

> +}
> +
> +void msg_do_writer(long key, int tid, long type, int child, int nreps)
> +{
> +	int i, size;
> +	int id;
> +	struct mbuffer buffer;
> +
> +	id = SAFE_MSGGET(key, 0);
> +	if (id != tid) {
> +		tst_brk(TFAIL,
> +			"Message queue mismatch in the writer of child group %d for message queue id %d",
> +			child, id);
> +	}
> +
> +	for (i = 0; i < nreps; i++) {
> +		memset(&buffer, 0, sizeof(buffer));
> +
> +		do {
> +			size = (lrand48() % 99);
> +		} while (size == 0);
> +		memset(buffer.data.pbytes, (key % 255), size);
> +		buffer.data.len = size;
> +		buffer.type = type;
> +		SAFE_MSGSND(id, &buffer, size + 1, 0);
> +		key++;
> +	}
> +}

And same here.

-- 
Cyril Hrubis
chrubis@suse.cz
