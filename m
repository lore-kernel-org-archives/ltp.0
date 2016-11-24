From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 24 Nov 2016 01:11:32 +0100
Subject: [LTP] [PATCH 1/1] testcases/mq_notify01: convert to use new
 test library API
In-Reply-To: <20161122080039.GB5620@rei.lan>
References: <20161121081327.8444-1-pvorel@suse.cz>
 <20161122080039.GB5620@rei.lan>
Message-ID: <20161124001132.5w65c3djdh42fotu@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

<snip>
> > @@ -191,28 +170,20 @@ static int do_test(struct test_case *tc)
> >  	case FD_FILE:
> >  		TEST(fd = open("/", O_RDONLY));
> >  		if (TEST_RETURN < 0) {
> > -			tst_resm(TFAIL, "can't open \"/\".");
> > -			result = 1;
> > -			goto EXIT;
> > +			tst_res(TFAIL, "can't open \"/\".");
> > +			goto CLEANUP;
> >  		}
> >  		break;
> >  	default:
> > -		/*
> > -		 * Open message queue
> > -		 */
> >  		TEST(fd =
> >  		     mq_open(QUEUE_NAME, O_CREAT | O_EXCL | O_RDWR, S_IRWXU,
> >  			     NULL));
> >  		if (TEST_RETURN < 0) {
> > -			tst_resm(TFAIL | TTERRNO, "mq_open failed");
> > -			result = 1;
> > -			goto EXIT;
> > +			tst_res(TFAIL | TTERRNO, "mq_open failed");
> > +			goto CLEANUP;
> >  		}
> >  	}

> These fds can be opened only once in the test setup and passed in the
> testcase structure. We do it usually as:

> static int file_fd;

> struct testcase tcases[] = {
> ...
> 	TYPE_NAME(file);
> 	.fd = &file_fd;
> ...
> }

> static void setup(void)
> {
> 	file_fd = creat("file", 0644);
> 	...
> }
IMHO if I reuse message queue between tests I need to delete messages before each test,
otherwise I don't get signal for SIGEV_SIGNAL and SIGEV_THREAD. I can empty them with
mq_receive() but is it worth of doing it?


Kind regards,
Petr
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20161124/f16ca218/attachment.sig>
