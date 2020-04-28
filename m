From: Aleksa Sarai <cyphar@cyphar.com>
Date: Tue, 28 Apr 2020 10:51:26 +1000
Subject: [LTP] [fs] ce436509a8: ltp.openat203.fail
In-Reply-To: <20200427142733.GD7661@rei>
References: <f969e7d45a8e83efc1ca13d675efd8775f13f376.1586830316.git.josh@joshtriplett.org>
 <20200427135210.GB5770@shao2-debian> <20200427142733.GD7661@rei>
Message-ID: <20200428005126.6wncibudt6ohghvc@yavin.dot.cyphar.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020-04-27, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
> > commit: ce436509a8e109330c56bb4d8ec87d258788f5f4 ("[PATCH v4 2/3] fs: openat2: Extend open_how to allow userspace-selected fds")
> > url: https://github.com/0day-ci/linux/commits/Josh-Triplett/Support-userspace-selected-fds/20200414-102939
> > base: https://git.kernel.org/cgit/linux/kernel/git/shuah/linux-kselftest.git next
> 
> This commit adds fd parameter to the how structure where LTP test was
> previously passing garbage, which obviously causes the difference in
> errno.
> 
> This could be safely ignored for now, if the patch gets merged the test
> needs to be updated.

It wouldn't be a bad idea to switch the test to figure out the ksize of
the struct, so that you only add bad padding after that. But then again,
this would be a bit ugly -- having CHECK_FIELDS would make this simpler.

-- 
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200428/16246614/attachment.sig>
