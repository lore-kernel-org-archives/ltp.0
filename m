From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 25 Aug 2020 09:38:20 -0400 (EDT)
Subject: [LTP] [PATCH] syscalls/setsockopt05: associate receiver with
 destination address
In-Reply-To: <d2a4fdfb-4686-eedc-a22b-464f9ed5982d@suse.cz>
References: <c73f6b2e1232d6a892ecef76370ea2cf6c7dd044.1598270814.git.jstancek@redhat.com>
 <de536b1b-0751-f50c-3869-b1b7956bda84@suse.cz>
 <1425720351.9865762.1598281277578.JavaMail.zimbra@redhat.com>
 <9821e566-3263-36fd-651e-4f5019e486e1@suse.cz>
 <285733961.9872750.1598285502957.JavaMail.zimbra@redhat.com>
 <d2a4fdfb-4686-eedc-a22b-464f9ed5982d@suse.cz>
Message-ID: <1390277350.9966000.1598362700248.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> On 24. 08. 20 18:11, Jan Stancek wrote:
> > Aren't we getting propagated ICMP error to send() from previous iteration
> > of the loop?
> > 
> > Per https://tools.ietf.org/html/rfc1122#page-78
> >   The application is also responsible to avoid confusion from a delayed
> >   ICMP
> >   error message resulting from an earlier use of the same port(s).
> 
> The test is using the loopback address. There should be no delay. We're
> running this test daily on 7 different kernel versions and 4 different
> archs and I've never seen it fail with ECONNREFUSED, ever.


Similar here, it runs daily dozens of times, but appears to fail sporadically
only on s390x.

> 
> But you can prove me wrong by adding a few debug prints around both
> send() calls.

1. extra prints
 65         for (i = 0; i < 1000; i++) {
 66                 sock = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
 67                 SAFE_CONNECT(sock, (struct sockaddr *)&addr, sizeof(addr));
 68                 printf("1 %d\n", i);
 69                 SAFE_SEND(1, sock, buf, BUFSIZE, MSG_MORE);
 70                 printf("2 %d\n", i);
 71                 SAFE_SETSOCKOPT_INT(sock, SOL_SOCKET, SO_NO_CHECK, 1);
 72                 printf("3 %d\n", i);
 73                 send(sock, buf, 1, 0);
 74                 printf("4 %d\n", i);
 75                 SAFE_CLOSE(sock);

1 246
2 246
3 246
4 246
1 247
2 247
3 247
4 247
1 248

safe_net.c:202: BROK: setsockopt05.c:69: send(3, 0x3ffc397db88, 4000, 32768) failed: ECONNREFUSED (111)

2. SO_NO_CHECK doesn't matter, following fails:
                sock = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
                SAFE_CONNECT(sock, (struct sockaddr *)&addr, sizeof(addr));
                SAFE_SEND(1, sock, buf, BUFSIZE, MSG_MORE);
                send(sock, buf, 1, 0);
                SAFE_CLOSE(sock);

3. MSG_MORE doesn't matter, following fails:
                sock = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
                SAFE_CONNECT(sock, (struct sockaddr *)&addr, sizeof(addr));
                SAFE_SEND(1, sock, buf, BUFSIZE, 0);
                SAFE_CLOSE(sock);

Regards,
Jan

