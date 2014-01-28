Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W89ch-0000sc-OX
	for ltp-list@lists.sourceforge.net; Tue, 28 Jan 2014 14:26:43 +0000
Date: Tue, 28 Jan 2014 15:26:13 +0100
From: chrubis@suse.cz
Message-ID: <20140128142612.GA7155@rei>
References: <1385553969-24473-1-git-send-email-alexey.kodanev@oracle.com>
	<20131212163910.GD10634@rei.Home> <52DFB880.2080705@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52DFB880.2080705@oracle.com>
Subject: Re: [LTP] [PATCH v3] network: tcp_fastopen: add TCP Fast Open test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Alexey Kodanev <alexey.kodanev@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> >> +struct tcp_func {
> >> +	void (*init)(void);
> >> +	void (*run)(void);
> >> +	void (*cleanup)(void);
> >> +};
> >> +static struct tcp_func tcp;
> >> +
> >> +#define MAX_THREADS	10000
> >> +static pthread_attr_t attr;
> >> +static pthread_t *thread_ids;
> >> +static int threads_num;
> >> +
> >> +static struct addrinfo *remote_addrinfo;
> >> +static struct addrinfo *local_addrinfo;
> >> +static const struct linger clo = { 1, 3 };
> >> +
> >> +static void cleanup(void)
> >> +{
> >> +	static int first = 1;
> >> +	if (!first)
> >> +		return;
> >> +	first = 0;
> > There is still chance for a race condition here. But this could be
> > easily fixed by pthread_once().
> >
> > static pthread_once_t cleanup_executed = PTHREAD_ONCE_INIT;
> >
> > static void do_cleanup(void)
> > {
> > 	/* Do the cleanup here */
> > }
> >
> > static void cleanup(void)
> > {
> > 	pthread_once(&cleanup_executed, do_cleanup);
> > }
> >
> > Thinking of the problems with LTP library thread safety again. One of
> > the solutions may be having two tst_res.c implementaions. Note that the
> > source of thread safety problems is the cleanup function which is
> > executed by the tst_brkm() and the exitval that is in the test library
> > too.
> >
> > If we did so then we will have tst_res.c we have now and one providing
> > thread safe implemenation using pthread synchronization primitives
> > (likely both will be implemented on the top of the common code).
> >
> > And if we could switch which one gets linked to a test at the linker
> > phase depending whether it uses pthreads or not the thread safety
> > problem will be fixed once for all.
> >
> > I will think about this a bit more.
> As I understand correctly we need to create one more library libltp_mt.a 
> and implement the same but in the thread-safe way, right?

That is one of the posible solutions.

I would create the thread safe library on the top of the one we have now
and created set of calls with _r suffix (as libc does with strerror(),
ctime(), ...). Then we can use these when needed and link the the test
against both -lltp and -lltp_mt (or whatever it gets called). That would
include all the tst_res() functions and maybe some other, we can add
these once they.

The open question is the callback() because we either need to redirect
all calls that gets the callback pointer as an parameter or create the
callback indirection (with pthread once) in the test. I would rather see
the second variant. What we can do is a macro that will decleare the
pthread once etc given the name of the real callback and the name of the
resulting function.

> So the following part of tst_brk() also requires synchronization, 
> tst_brk_entered in particular.
> 
> void tst_brk(int ttype, char *fname, void (*func) (void), char *arg_fmt, 
> ...)
> {
>        ...
> 
>          /*
>           * If no cleanup function was specified, just return to the caller.
>           * Otherwise call the specified function.
> */
>          if (func != NULL) {
> tst_brk_entered++;
>                  (*func) ();
> tst_brk_entered--;
> }
>          if (tst_brk_entered == 0)
> tst_exit();
> 
> }
> 
> tst_brk_entered and T_exitval, tst_count can be implemented with gcc 
> atomic bultins. Cleanup function as you suggested will be implemented 
> with pthread_once in a test. Then we can exit with TCONF if a test with 
> libltp thread-safety requirements can't find gcc atomic built-ins.

This part is a hack for being able to call safe macros from within the
test cleanup(). All safe macros call tst_brkm() if something has failed
which will exit the cleanup() prematurely. But this does not work well
or reliably. I would vote for removing this part and forbiding calling
safe macros from within the test cleanup(), people tend to pass the
cleanup function pointer to these without thinking which creates
infinite recursion and the test is killed when stack is filled up...

> Anyway, I'm thinking that at least for now I won't use tst_res.c in the 
> test, once thread-safe ltplib is done I will make use of it here.

OK. But we should fix the LTP lib as well.

> >> +
> >> +static void make_client_request(void)
> >> +{
> >> +	client_msg[0] = start_byte;
> >> +
> >> +	/* set size for reply */
> >> +	*(uint16_t *)(client_msg + 1) = htons(server_msg_size);
> > This will generate unaligned access on some architectures.
> >
> > What you need is to set the value byte by byte:
> >
> > client_msg[1] = (sever_msg_size>>8) & 0xff;
> > client_msg[2] = sever_msg_size & 0xff;
> >
> >> +	client_msg[client_msg_size - 1] = end_byte;
> >> +}
> >> +
> >> +static int parse_client_request(const char *recv_msg)
> >> +{
> >> +	int size = ntohs(*(uint16_t *)(recv_msg + 1));
> > Here as well, you need to construct the value byte by byte as:
> >
> > uint16_t val = htons(((((uint16_t)recv_msg[1])<<8) + recv_msg[2]));
> OK, but I think it is better to use an union as follows, isn't it?
> 
> union net_size_field {
>          char bytes[2];
>          uint16_t value;
> };
> 
> static void make_client_request(void)
> {
>          ...
>          union net_size_field net_size;
>          net_size.value = htons(server_msg_size);
>          client_msg[1] = net_size.bytes[0];
>          client_msg[2] = net_size.bytes[1];
>          ..
> }
> 
> static int parse_client_request(const char *recv_msg)
> {
>          union net_size_field net_size;
>          net_size.bytes[0] = recv_msg[1];
>          net_size.bytes[1] = recv_msg[2];
>          int size = ntohs(net_size.value);
>          ...
> }
> 

That should work as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
WatchGuard Dimension instantly turns raw network data into actionable 
security intelligence. It gives you real-time visual feedback on key
security issues and trends.  Skip the complicated setup - simply import
a virtual appliance and go from zero to informed in seconds.
http://pubads.g.doubleclick.net/gampad/clk?id=123612991&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
