From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 20 May 2019 13:30:27 +0300
Subject: [LTP] [PATCH v2] syscalls/preadv203: Add basic RWF_NOWAIT test
In-Reply-To: <20190520100824.GA25813@rei.lan>
References: <20190404141611.15192-1-chrubis@suse.cz>
 <20190520100824.GA25813@rei.lan>
Message-ID: <CAOQ4uxgNGK=QcGcmDpjt0jhWC9=E3egSpv5G0-7tXx7bKQD7gw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, May 20, 2019 at 1:08 PM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> Ping, anybody has any comments or can be this be this merged?
>

I have no objection to this test, but I have a question. Your claim is:
"We are attempting to trigger the EAGAIN path for the RWF_NOWAIT flag."

Seems like you have gone to a great length of effort to achieve this.
Wouldn't it be sufficient to do a single preadv2 after fsync+drop_caches in
order to observe EAGAIN?

There are several other ways to get EAGAIN, like DIO read/write when
page cache *is* populated.

Question is, how much is the test trying to cover.

Thanks,
Amir.
