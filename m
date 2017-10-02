From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 2 Oct 2017 14:29:20 +0200
Subject: [LTP] [PATCH 1/1] syscalls, lib: Use SAFE_{BIND, LISTEN,
 SOCKET} macros
In-Reply-To: <87bmlpx195.fsf@our.domain.is.not.set>
References: <20170929231036.32262-1-pvorel@suse.cz>
 <87bmlpx195.fsf@our.domain.is.not.set>
Message-ID: <20171002122920.rpurivi6x46duh4c@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard, Cyril,

> Hello Petr,

> > Patch was made thanks to Coccinelle.
> Very good. Also how about including the Coccinelle patch in the tools or
> scripts folder?

Cyril, do you like this idea?

Well, I'm not much proud on that script, it's my first Coccinelle script :-)

@test_h@
@@
#include "test.h"

@tst_test_h@
@@
#include "tst_test.h"

// test.h does not include safe_macros.h
@safe_macros_h@
@@
#include "safe_macros.h"

@is_safe_socket@
@@
int safe_socket(...) {...}

// SAFE_BIND
@old_safe_bind depends on test_h@
expression sockfd, sockaddr, addrlen;
identifier cleanup_fn;
expression e, x;
constant TFAIL;
@@
-if (bind(sockfd, sockaddr, addrlen) < 0) {
-	tst_brkm(e, cleanup_fn, ...);
(
-	return -1;
|
)
	... when != x & TFAIL
-}
+SAFE_BIND(cleanup_fn, sockfd, sockaddr, addrlen);

@safe_bind depends on tst_test_h@
expression sockfd, sockaddr, addrlen;
expression e, x;
constant TFAIL;
@@
-if (bind(sockfd, sockaddr, addrlen) < 0) {
-	tst_brk(e, ...);
(
-	return -1;
|
)
	... when != x & TFAIL
-}
+SAFE_BIND(sockfd, sockaddr, addrlen);


// SAFE_SOCKET
@old_safe_socket depends on test_h && !is_safe_socket@
expression family, type, protocol;
identifier fd;
identifier cleanup_fn;
expression e, x;
constant TFAIL;
@@
-fd = socket(family, type, protocol);
-if (fd < 0) {
-	tst_brkm(e, cleanup_fn, ...);
(
-	return -1;
|
)
	... when != x & TFAIL
-}
+fd = SAFE_SOCKET(cleanup_fn, family, type, protocol);

@safe_socket depends on tst_test_h && !is_safe_socket@
expression family, type, protocol;
identifier fd;
expression e, x;
constant TFAIL;
@@
-fd = socket(family, type, protocol);
-if (fd < 0) {
-	tst_brk(e, ...);
(
-	return -1;
|
)
	... when != x & TFAIL
-}
+fd = SAFE_SOCKET(family, type, protocol);


// SAFE_FSETXATTR
// not used so far, not in old
@safe_fsetxattr depends on tst_test_h@
expression fd, name, value, flags, size;
identifier r;
expression e, x;
constant TFAIL;
@@
-r = fsetxattr(fd, name, value, size, flags);
-if (r < 0) {
-	tst_brk(e, ...);
(
-	return -1;
|
)
	... when != x & TFAIL
-}
+SAFE_FSETXATTR(fd, name, value, size, flags);

// SAFE_LISTEN
@safe_listen depends on tst_test_h@
expression backlog;
identifier socket;
identifier r;
expression e, x;
constant TFAIL;
@@
-r = listen(socket, backlog); if (r < 0) {
-	tst_brk(e, ...);
(
-	return -1;
|
)
	... when != x & TFAIL
-}
+SAFE_LISTEN(socket, backlog);

@safe_listen2 depends on tst_test_h@
expression backlog;
identifier socket;
identifier r;
expression e, x;
constant TFAIL;
@@
-if (listen(socket, backlog) < 0) {
-	tst_brk(e, ...);
(
-	return -1;
|
)
	... when != x & TFAIL
-}
+SAFE_LISTEN(socket, backlog);

@old_safe_listen depends on test_h@
expression backlog;
identifier socket, cleanup_fn;
identifier r;
expression e, x;
constant TFAIL;
@@
-r = listen(socket, backlog); if (r < 0) {
-	tst_brk(e, ...);
(
-	return -1;
|
)
	... when != x & TFAIL
-}
+SAFE_LISTEN(cleanup_fn, socket, backlog);

@old_safe_listen2 depends on test_h@
expression backlog;
identifier socket, cleanup_fn;
identifier r;
expression e, x;
constant TFAIL;
@@
-if (listen(socket, backlog) < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup_fn, "server listen failed");
-		return -1;
-	}
+SAFE_LISTEN(cleanup_fn, socket, backlog);

// SAFE_SENDTO
// not used so far, not in old
@safe_sendto depends on tst_test_h@
expression fd, buf, len, flags, dest_addr, addrlen;
identifier r;
expression e, x;
constant TFAIL;
@@
-r = sendto(fd, buf, len, flags, dest_addr, addrlen);

-if (r < 0) {
-	tst_brk(e, ...);
(
-	return -1;
|
)
	... when != x & TFAIL
-}
+SAFE_SENDTO(1, fd, buf, len, flags, dest_addr, addrlen);

// INCLUDE
@depends on !safe_macros_h && (old_safe_bind || old_safe_listen || old_safe_listen2 || old_safe_socket)@
@@
#include "test.h"
+#include "safe_macros.h"
