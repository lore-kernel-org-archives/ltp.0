From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 25 Aug 2020 11:43:18 +0200
Subject: [LTP] [PATCH] syscalls/setsockopt05: associate receiver with
 destination address
In-Reply-To: <285733961.9872750.1598285502957.JavaMail.zimbra@redhat.com>
References: <c73f6b2e1232d6a892ecef76370ea2cf6c7dd044.1598270814.git.jstancek@redhat.com>
 <de536b1b-0751-f50c-3869-b1b7956bda84@suse.cz>
 <1425720351.9865762.1598281277578.JavaMail.zimbra@redhat.com>
 <9821e566-3263-36fd-651e-4f5019e486e1@suse.cz>
 <285733961.9872750.1598285502957.JavaMail.zimbra@redhat.com>
Message-ID: <d2a4fdfb-4686-eedc-a22b-464f9ed5982d@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 24. 08. 20 18:11, Jan Stancek wrote:
> Aren't we getting propagated ICMP error to send() from previous iteration
> of the loop?
> 
> Per https://tools.ietf.org/html/rfc1122#page-78
>   The application is also responsible to avoid confusion from a delayed ICMP
>   error message resulting from an earlier use of the same port(s).

The test is using the loopback address. There should be no delay. We're
running this test daily on 7 different kernel versions and 4 different
archs and I've never seen it fail with ECONNREFUSED, ever.

But you can prove me wrong by adding a few debug prints around both
send() calls.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
