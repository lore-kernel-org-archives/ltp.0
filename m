From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 21 Jul 2021 16:27:15 +0200
Subject: [LTP] [PATCH v4 1/5] libs/libltpnewipc/libnewipc.c: Add
 msg_do_reader/msg_do_writer function
In-Reply-To: <1615550541-21714-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <20201111163114.GB23576@yuki.lan>
 <1615550541-21714-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <YPguw96IP/TehZVe@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
First of all sorry for the long delay.

> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  include/libnewipc.h           | 11 +++++
>  libs/libltpnewipc/libnewipc.c | 75 +++++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
> 
> diff --git a/include/libnewipc.h b/include/libnewipc.h
> index 075364f85..0f099c939 100644
> --- a/include/libnewipc.h
> +++ b/include/libnewipc.h
> @@ -45,6 +45,14 @@
>  #define INT_SIZE	4
>  #define MODE_MASK	0x01FF
>  
> +struct mbuffer {
> +	long type;
> +	struct {
> +		char len;
> +		char pbytes[99];
> +	} data;
> +};
> +
>  key_t getipckey(const char *file, const int lineno);
>  #define GETIPCKEY() \
>  	getipckey(__FILE__, __LINE__)
> @@ -59,4 +67,7 @@ void *probe_free_addr(const char *file, const int lineno);
>  
>  time_t get_ipc_timestamp(void);
>  
> +void msg_do_reader(long key, int tid, long type, int child, int nreps);
> +
> +void msg_do_writer(long key, int tid, long type, int child, int nreps);
>  #endif /* newlibipc.h */
> diff --git a/libs/libltpnewipc/libnewipc.c b/libs/libltpnewipc/libnewipc.c
> index d0974bbe0..09871b421 100644
> --- a/libs/libltpnewipc/libnewipc.c
> +++ b/libs/libltpnewipc/libnewipc.c
> @@ -99,3 +99,78 @@ time_t get_ipc_timestamp(void)
>  
>  	return ts.tv_sec;
>  }
> +
> +static int verify(char *buf, char val, int size, int child)
> +{
> +	while (size-- > 0) {
> +		if (*buf++ != val) {
> +			tst_res(TFAIL,
> +				"Verify error in child %d, *buf = %x, val = %x, size = %d",
> +				child, *buf, val, size);

Actually this piece of code had a bug in the original version as well,
as we do *buf++ we end up one byte after the position we wanted to
print if we ever got wrong byte, possibly out of the buffer as well.

So I guess that this will be much better and easier to read with usuall
for loop and array subscript:

	for (i = 0; i < size; i++) {
		if (buf[i] != val)  {
		...

Also we report failure in the msg_do_reader() so I guess that it would
be slightly better to report TINFO with the details here and let the
msg_do_reader() report the failure.

> +			return 1;
> +		}
> +	}
> +	return 0;
> +}
> +
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

We set the relevant part of the buffer with (key % 255), do we really
have to clear it here?

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

-- 
Cyril Hrubis
chrubis@suse.cz
