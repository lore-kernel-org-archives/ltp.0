From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 2 Oct 2018 19:19:46 +0300
Subject: [LTP] [RFC PATCH 2/5] runtest/syscalls: rename CVE test cases
In-Reply-To: <20181002125354.GE24796@rei>
References: <1536849882-28897-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1536849882-28897-3-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20181002125354.GE24796@rei>
Message-ID: <d6da64c1-c4e5-0344-0470-b9932d2b0107@oracle.com>
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

Yes. No objection at all.

