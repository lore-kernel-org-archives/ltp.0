From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 28 Aug 2017 07:54:52 -0400 (EDT)
Subject: [LTP] RFC: Drop support for libnuma API version < 2
In-Reply-To: <20170828083904.4kc7ndp2jdwugs7f@dell5510>
References: <20170828083904.4kc7ndp2jdwugs7f@dell5510>
Message-ID: <367492676.4269530.1503921292583.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi,
> 
> I'm just about to rewrite mbind/mbind01 test to new API. This test (and some
> other tests)
> still support libnuma API version < 2. Libnuma version 2 was released in
> 2008. Do we still want
> to support older versions?

Hi,

I would go with "no" for writing new code against libnuma < 2. Looking at
LTP, I see only handful of tests that have specific code for old (< 2)
libnuma.

But I'd like to keep LTP compilable with these old distros,
since there are lot of tests that still can be used.

Regards,
Jan
