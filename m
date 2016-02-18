From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 18 Feb 2016 18:02:03 +0800
Subject: [LTP] [PATCH 1/3] llistxattr/llistxattr01.c: add new testcase
In-Reply-To: <20160210140414.GD10106@rei.lan>
References: <1454058489-25625-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20160210140414.GD10106@rei.lan>
Message-ID: <56C5969B.4080107@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

? 2016/02/10 22:04, Cyril Hrubis ??:
> Hi!
>> +#ifdef HAVE_ATTR_XATTR_H
>> +#define SECURITY_KEY   "security.symtest"
>                                       ^
>
> 			   Why symtest, I would preffere to have 'ltp'
>                             substring in everything that testcases create
>                             so that is clear where it came from
>
>> +#define SECURITY_KEY_INIT      "security.selinux"
>> +#define VALUE  "test"
>> +#define VALUE_SIZE     4
>> +#define KEY_SIZE    17
>
>> +static void verify_llistxattr(void)
>> +{
>> +	int n;
>> +	int se = 1;
>> +	int size = 64;
>> +	char buf[size];
>> +	char cmp_buf1[size];
>> +	char cmp_buf2[size];
>> +
>> +	/* check selinux initialized attr */
>> +	n = lgetxattr("symlink", SECURITY_KEY_INIT, NULL, 0);
>> +	if (n == -1) {
>> +		if (errno == ENOATTR) {
>> +			se = 0;
>> +		} else {
>> +			tst_brkm(TFAIL | TERRNO, cleanup,
>> +				 "lgetxattr() failed");
>> +		}
>> +	}
> I do not like the special case for seliux here. What we should do
> instead is to:
>
> * Create file/symlink and store it's attribute list
>
> * Add an attribute
>
> * Check that the list has exactly one more attribute
>
> * Remove the file/symlink
>
>
If we don't check that selinux adds default attribute to symlinks, What 
about the return value.

We're not going to judge the size of  the extended attribute name list. 
That's OK?

> And there should be a comment that selinux adds default attribute to
> newly created files/symlinks.
>
>
>> +	TEST(llistxattr("symlink", buf, size));
>> +	if (TEST_RETURN == -1) {
>> +		tst_resm(TFAIL | TTERRNO, "llistxattr() failed");
>> +		return;
>> +	}
>> +
>> +	if (TEST_RETURN != KEY_SIZE*(1 + se)) {
>> +		tst_resm(TFAIL, "llistxattr() retrieved %li bytes, "
>> +			 "expected %i", TEST_RETURN, KEY_SIZE*2);
>> +		return;
>> +	}
>> +
>> +	/*
>> +	* The list of names is returned as an unordered array of
>> +	* NULL-terminated character strings.
>> +	*/
>> +	if (se == 1) {
>> +		memcpy(cmp_buf1, SECURITY_KEY, KEY_SIZE);
>> +		memcpy(cmp_buf1+KEY_SIZE, SECURITY_KEY_INIT, KEY_SIZE);
>> +		memcpy(cmp_buf2, SECURITY_KEY_INIT, KEY_SIZE);
>> +		memcpy(cmp_buf2+KEY_SIZE, SECURITY_KEY, KEY_SIZE);
>> +
>> +		if (memcmp(buf, cmp_buf1, KEY_SIZE*(1 + se))&&  memcmp(buf, cmp_buf2, KEY_SIZE*(1 + se))) {
>> +			tst_resm(TFAIL, "name list mismatched");
>> +			return;
>> +		}
>> +	} else {
>> +		if (memcmp(buf, SECURITY_KEY, KEY_SIZE*(1 + se))) {
>> +			tst_resm(TFAIL, "name list mismatched");
>> +			return;
>> +		}
>> +	}
> If you have actually checked that the list has 2 attributes all you
> need to do here is to check that it includes both attributes.
>
> All you need is a function that takes attribute list and checks that
> there is attribute included, i.e.
>
> int has_attribute(const char *list, unsigned int llen, const char *attr)
> {
> 	unsigned int i;
>
> 	for (i = 0; i<  llen; i += strlen(list + i) + 1) {
> 		if (!strcmp(list+i, attr))
> 			return 1;
> 	}
>
> 	return 0;
> }
>
> ...
> 	if (!has_attribute(buf, size, attr_1)) {
> 		tst_resm(TFAIL, "Missing attribute %s", attr_1);
> 		return;
> 	}
>
> 	if (!has_attribute(buf, size, attr_2)) {
> ...
>
>



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20160218/30c84406/attachment.html>
