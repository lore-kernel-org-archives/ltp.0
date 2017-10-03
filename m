From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 3 Oct 2017 03:58:17 -0400 (EDT)
Subject: [LTP] [PATCH] [RFC] tst_test: Add support for array of
	test	functions
In-Reply-To: <20170727081437.27995-1-chrubis@suse.cz>
References: <20170727081437.27995-1-chrubis@suse.cz>
Message-ID: <860483630.25581747.1507017497043.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> This commits add third option for specifying the test functions in an
> NULL terminated array of function pointers + converts two testcases.

Hi,

What would be the benefits?

- it's almost same amount of code
- it makes tst_test interface bit more complicated
- as a user I'd probably go with test_all(), since it's most straight-forward
- if those test funcs have parameter other than void, you still need
  to use the old way

Regards,
Jan
