From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 3 Jan 2019 13:59:57 -0800
Subject: [LTP] [bug] problems with migration of huge pages with
 v4.20-10214-ge1ef035d272e
In-Reply-To: <6e341052-fe38-b71c-ebb2-47e2e34f5963@oracle.com>
References: <1323128903.93005102.1546461004635.JavaMail.zimbra@redhat.com>
 <6e608107-e071-90c0-bd73-4215325433c1@oracle.com>
 <dc056866-0e60-6ffa-54d5-5cafa1a4a53f@oracle.com>
 <1808265696.93134171.1546519652798.JavaMail.zimbra@redhat.com>
 <495081357.93179893.1546535169172.JavaMail.zimbra@redhat.com>
 <6e341052-fe38-b71c-ebb2-47e2e34f5963@oracle.com>
Message-ID: <20190103135957.68d1ef31f4e125a1a67bbcb9@linux-foundation.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, 3 Jan 2019 13:44:20 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> Do I simply send a 'revert'
> patch to you and the list?

Probably that would be best, to give us a changelog, to make sure that
the correct things are reverted and so we have something which you
tested.

