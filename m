From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 24 Aug 2020 12:11:42 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/setsockopt05: associate receiver with
 destination address
In-Reply-To: <9821e566-3263-36fd-651e-4f5019e486e1@suse.cz>
References: <c73f6b2e1232d6a892ecef76370ea2cf6c7dd044.1598270814.git.jstancek@redhat.com>
 <de536b1b-0751-f50c-3869-b1b7956bda84@suse.cz>
 <1425720351.9865762.1598281277578.JavaMail.zimbra@redhat.com>
 <9821e566-3263-36fd-651e-4f5019e486e1@suse.cz>
Message-ID: <285733961.9872750.1598285502957.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On 24. 08. 20 17:01, Jan Stancek wrote:
> > I assumed it's from previous one, not partial one. From man(7) udp:
> > 
> >  ECONNREFUSED
> >               No receiver was associated with the destination address.
> >               This might be caused by a previous packet sent over the
> >               socket.
> > 
> 
> Wait, looking closer at the error message, it looks like send(MSG_MORE)
> is broken on your test kernel. Let me quote the man page here:

Aren't we getting propagated ICMP error to send() from previous iteration
of the loop?

Per https://tools.ietf.org/html/rfc1122#page-78
  The application is also responsible to avoid confusion from a delayed ICMP
  error message resulting from an earlier use of the same port(s).

