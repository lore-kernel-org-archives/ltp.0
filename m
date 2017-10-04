From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 4 Oct 2017 08:25:00 -0400 (EDT)
Subject: [LTP] [PATCH 2/2] security/dirtyc0w: synchronize parent and
 child
In-Reply-To: <20171004120240.GA29423@rei>
References: <94518262a76edca533440acb73611eb93184dc90.1507113734.git.jstancek@redhat.com>
 <1300ca0b5103f4f145af3be1a0295974a04dcae8.1507113734.git.jstancek@redhat.com>
 <20171004120240.GA29423@rei>
Message-ID: <47778538.26248540.1507119900299.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > +static const char *const resource_files[] = {
> > +	TEST_APP,
> > +	NULL,
> > +};
> 
> I do not get why we need the test binary to be listed as resource file,
> the rest seems OK to me.

Since the test is using tmpdir, we either need exec*p* variant and
set PATH or copy binary to tmpdir. I took inspiration from creat07.

Copy approach is slightly more convenient when running test from git tree:
# ./dirtyc0w

But I can replace it with execvpe() - user would just need to setup PATH
before running it from git tree:
# env PATH=`pwd`:$PATH ./dirtyc0w

Regards,
Jan
