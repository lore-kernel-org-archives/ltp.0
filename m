From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 24 Aug 2020 17:21:28 +0200
Subject: [LTP] [PATCH] syscalls/setsockopt05: associate receiver with
 destination address
In-Reply-To: <1425720351.9865762.1598281277578.JavaMail.zimbra@redhat.com>
References: <c73f6b2e1232d6a892ecef76370ea2cf6c7dd044.1598270814.git.jstancek@redhat.com>
 <de536b1b-0751-f50c-3869-b1b7956bda84@suse.cz>
 <1425720351.9865762.1598281277578.JavaMail.zimbra@redhat.com>
Message-ID: <9821e566-3263-36fd-651e-4f5019e486e1@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 24. 08. 20 17:01, Jan Stancek wrote:
> I assumed it's from previous one, not partial one. From man(7) udp:
> 
>  ECONNREFUSED
>               No receiver was associated with the destination address.
>               This might be caused by a previous packet sent over the socket.
> 

Wait, looking closer at the error message, it looks like send(MSG_MORE)
is broken on your test kernel. Let me quote the man page here:

>        MSG_MORE (since Linux 2.4.4)
>               The  caller  has  more data to send.  This flag is used with TCP
>               sockets to obtain the same effect as the TCP_CORK socket  option
>               (see tcp(7)), with the difference that this flag can be set on a
>               per-call basis.
> 
>               Since Linux 2.6, this flag is also supported  for  UDP  sockets,
>               and  informs the kernel to package all of the data sent in calls
>               with this flag set into a single datagram which  is  transmitted
>               only  when  a call is performed that does not specify this flag.
>               (See also the UDP_CORK socket option described in udp(7).)

The data from the SAFE_SEND() call are supposed to stay in kernel buffer
until the send() call where we (intentionally) ignore the return value.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
