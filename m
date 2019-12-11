From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed, 11 Dec 2019 15:43:24 +0100
Subject: [LTP] [PATCH] lib: Add fifo library
In-Reply-To: <20191210143256.GA30547@rei.lan>
References: <20191209064110.67975-1-lkml@jv-coder.de>
 <20191210143256.GA30547@rei.lan>
Message-ID: <5535e28a-6cad-c64e-c2a4-5fd2beec4c65@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

I was expecting some kind of objection from you (and maybe others),
that is why I send this patch before implementing
everything (e.g. timeouts and documentation).
>> +
>> +#define INIT_FIFO_FUNCTION(req_mode, ack_mode) \
>> +    char path_req[PATH_MAX]; \
>> +    char path_ack[PATH_MAX]; \
>> +    if (!FIFO_DIR) \
>> +        tst_brk(TBROK, "you must call tst_fifo_init first"); \
>> +    snprintf(path_req, sizeof(path_req), "%s/tst_fifo_%s.req", FIFO_DIR, name); \
>> +    snprintf(path_ack, sizeof(path_ack), "%s/tst_fifo_%s.ack", FIFO_DIR, name);
>> +    //if (required_mode && access(path, required_mode)) \
>> +     //   tst_brk(TBROK, "cannot access '%s'", path);
> If nothing else this macro is a reason to nack this patchset, it's quite
> ugly as it is.
You are right, I will probably turn it into a function. I don't like it 
either.
> I was wondering if we can could keep the fds open, but I guess that the
> code is depending on a fact that the processes are blocked and
> synchronized on open() on the fifo, right?
Yes that, and the fact, that keeping the handle open in shell script is 
harder.
>
> But if that's true we do not need full blown bidirectional communication
> for the memcg tests. We just need one fifo, where the parent reads from
> it and the C child writes there after it finished allocation. The parent
> will either get read some data or the read in the parent will return
> with 0 (EOF), if the other side of the fifo has been closed (the process
> killed).
At first I tired it unidirectional, but that has the disadvantage, that 
the receiver has
to be able to split messages. I explained it shortly in the commit message:

If a writer writes two messages without waiting for the receiver to 
receive it completely,
the receiver can read both messages with one read from the queue.

A sends 'foo' and blocks
B opens the fifio
A unblocks and sends 'bar'
B reads from the queue -> 'foobar'

To me the usage of two queues has two advantages:
1. No need to split messages on the receiver side
2. We have a full synchronization point, which makes reasoning a lot simpler

Regarding the memcg implementation:
I thought just replacing the current signal mechanism with new api 
should work:
The c child blocks on a pipe it reads from, the shell script sends a 
command through
this pipe. If the shell script tries to send the next command before the 
c child is ready
to process another command, the script blocks at the fifo open and waits 
for the child.
(This is where the race condition is in memcg_process).
The c child does not have to tell the shell script, that it is finished, 
the current polling
implemented works good enough. The advantage here is, that a dying child 
during
fifo communication is not a use case.

If the child can die while the shell script waits for fifo 
communication, the only
possible solution would to keep the fifo open in the child and parent, 
because
otherwise if the child dies, while the parent has not yet opened the 
pipe, it
will still block forever. -> This would require always open handle on 
client side
and prevent any kind of synchronization.

>> +void tst_fifo_init(void)
>> +{
>> +    if (tst_tmpdir_created()) {
>> +        FIFO_DIR = tst_get_tmpdir();
>> +        setenv(FIFO_ENV_VAR, FIFO_DIR, 1);
>> +    } else {
>> +        FIFO_DIR = getenv(FIFO_ENV_VAR);
>> +    }
> Shouldn't the env variable take precedence?
> I wonder if there would be a case where two tests each with it's own
> temporary directory would need to communicate. But I guess that we can
> fix this at any point

Yesno: I expect that there is only one "top-level-test". This is either 
a c test or
a shell script. If the shell script executes a c program, it is most 
likely a helper
(like tst_fifo_proc in my test case) and this helper does not use the 
main function
from tst_test and is supposed to use the temporary directory of it's 
parent and thus
it does not create it's own temporary directory.
If the main test is a c program, it either uses helpers like described 
above or it forks itself.
The fork does not need to call tst_fifo_init anyway.

So I see these two options as mutually exclusive anyway. But you may be 
right.

>> +int tst_fifo_receive(const char *name, char *data, int maxlen)
>> +{
>> +    int fd;
>> +    int nbyte;
>> +    int pos;
>> +    INIT_FIFO_FUNCTION(R_OK, W_OK);
>> +
>> +    fd = SAFE_OPEN(path_req, O_RDONLY);
>> +    pos = 0;
>> +    while (1) {
>> +        nbyte = SAFE_READ(0, fd, data + pos, maxlen - pos);
>> +        if (nbyte == 0)
>> +            break;
>> +        pos += nbyte;
>> +        if (pos == maxlen)
>> +            tst_brk(TBROK, "buffer is not big enough");
>> +    }
>> +
>> +    SAFE_CLOSE(fd);
>> +
>> +    fd = SAFE_OPEN(path_ack, O_WRONLY);
>> +    SAFE_WRITE(1, fd, "OK", 2);
>> +    SAFE_CLOSE(fd);
> I'm not sure we want to implement automatic ack like this. Why can't we
> just keep this as generic two-directional communication. I would also
> say that code that explicitly reads acks from the pipe would be easier
> to read as well, because there will be less hidden in the library.
That depends on the semantic of the functions.
As written above, I like to see them as synchronization points
>
>> +    data[pos] = 0;
>> +    return pos;
>> +}
> These functions would be better if they both included a timeout
> parameter. The fifo fds would have to be opened in non-blocking
> and we would have to use poll(). That way we wouldn't end up stuck if
> the other side is not dead but got stuck somehow.
Yes, completely right, I forgot to write that I was planing to implement 
this and just
haven't done it to discuss the basic api first.
> Can we please create a small C helper, as we do for checkpoints, so that
> we will have only one implementation of the FIFO?
Makes sense, but makes "keeping file handles open" even more impossible.

J?rg
