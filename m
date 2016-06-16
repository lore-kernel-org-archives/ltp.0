From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 16 Jun 2016 03:08:18 -0400 (EDT)
Subject: [LTP] [PATCH] lib: add tst_read_meminfo / tst_get_avail_mem
In-Reply-To: <20160616052544.GA18852@gmail.com>
References: <cad01181438a055f45b32fc28b33a8b8da74b768.1465903335.git.jstancek@redhat.com>
 <CAEemH2fGEGXftvF_HttR18KSbp8YRL_zaMhb38MQ4cpXqr-fMg@mail.gmail.com>
 <1589618283.6491776.1465976075619.JavaMail.zimbra@redhat.com>
 <57614F55.9090407@redhat.com> <20160616052544.GA18852@gmail.com>
Message-ID: <1809783770.6955910.1466060898915.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Li Wang" <liwang@redhat.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 16 June, 2016 7:25:44 AM
> Subject: Re: [LTP] [PATCH] lib: add tst_read_meminfo / tst_get_avail_mem
> 
> On Wed, Jun 15, 2016 at 02:51:33PM +0200, Jan Stancek wrote:
> > On 06/15/2016 09:34 AM, Jan Stancek wrote:
> > 
> > How about something like this?
> 
> This one looks better, just have a little comments as below:
> 
> > static int walk_file_lines(const char *filename, walk_func func,
> > 			   void *func_priv)
> > {
> > 	FILE *fp;
> > 	char line[BUFSIZ];
> > 
> > 	fp = fopen(filename, "r");
> > 	if (fp == NULL)
> > 		tst_brk(TBROK | TERRNO, "fopen %s", path_meminfo);
> 
> A typo here, the 'path_meminfo' should be replaced by 'filename'.
> 
> > static int match_colonpair_str_long(const char *line, void *priv)
> > {
> > 	struct colonpair_str_long *s = priv;
> > 	char buf[BUFSIZ];
> > 	long val;
> > 
> > 	if (sscanf(line, "%64s %ld", buf, &val) == 2) {
> > 		/* strip colon for comparison with key */
> > 		buf[strlen(buf) - 1] = '\0';
> 
> If manual set the last character as '\0', there will be limit this
> match function area.
> 
> e.g.
>   # cat /proc/stat | grep processes
>       processes 129493
> 
> A caller can not get correct value of the processes, since the
> string saved in buf[] as: 'p' 'r' 'o' 'c' 'e' 's' 's' 'e' '\0',
> it will disturb the mathing result and return 0.

That was expected, since you're using it to parse a different format.

> 
> My proposal is to have a simple choice here:
> 
> /* strip colon for comparison with key */
> 	if (buf[strlen(buf) -1] == ':')
> 		buf[strlen(buf) -1] = '\0';
> > 
> > long tst_get_avail_mem(void)
> > {
> > 	long mem_available;
> > 
> > 	mem_available = tst_get_meminfo("MemAvailable");
> > 	if (mem_available == -1) {
> > 		mem_available = tst_get_meminfo("MemFree");
> > 		mem_available += tst_get_meminfo("Cached");
> > 	}
> > 
> > 	return mem_available;
> > }
> 
> I'd like to add new callers for reading '/proc/stat' and
> '/proc/self/status' to verify read_colonpair_str_long() function.
> 
> static const char *path_proc_stat = "/proc/stat";
> static const char *path_self_status = "/proc/self/status";
> 
> long tst_get_stat(const char *key)
> {
> 	return read_colonpair_str_long(path_proc_stat, key, -1);
> }
> 
> long tst_get_self_status(const char *key)
> {
> 	return read_colonpair_str_long(path_self_status, key, -1);
> }

I'm now considering exposing just a parse function, I'd like to
avoid having separate function for each proc file. And possibly
more than one since those 2 proc files you mentioned don't have
uniform format for all content.

Regards,
Jan
