From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 8 Oct 2018 12:52:58 +0300
Subject: [LTP] [RFC PATCH 2/5] runtest/syscalls: rename CVE test cases
In-Reply-To: <20181002125354.GE24796@rei>
References: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1536849882-28897-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20181002125354.GE24796@rei>
Message-ID: <94f442a7-e9ff-6377-40ce-fd81e32ae19b@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 10/02/2018 03:53 PM, Cyril Hrubis wrote:
> Hi!
> Can we do this the other way around?
> 
> I.e. rename the source files to match the syscall name and then patch
> the cve runtest file to map the cve-* identifiers to the test names?
> 

By the way,

should I rename them right into testcases/cve or move to a corresponding
directory in testcases/kernel/syscalls?

I.e.

testcases/cve/cve-2017-6951.c -> testcases/cve/request_key05.c

or

testcases/cve/cve-2017-6951.c ->
testcases/kernel/syscalls/request_key/request_key05.c

?

I assume you propose the latter option, correct?


Thanks.
