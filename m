From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 26 Aug 2019 08:52:18 -0400 (EDT)
Subject: [LTP] [PATCH v4 2/4] BPF: Sanity check creating and updating
 maps
In-Reply-To: <20190826111024.19053-3-chrubis@suse.cz>
References: <20190826111024.19053-1-chrubis@suse.cz>
 <20190826111024.19053-3-chrubis@suse.cz>
Message-ID: <456316863.8154593.1566823938723.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> +
> +static const struct map_type map_types[] = {
> +	{BPF_MAP_TYPE_HASH, "hash", 8, &key8},
> +	{BPF_MAP_TYPE_ARRAY, "array", 4, &key4}
> +};
> +
> +void run(unsigned int n)
> +{
> +	int fd, i;
> +	void *key = *map_types[n].key;
> +
> +	memset(attr, 0, sizeof(*attr));
> +	attr->map_type = map_types[n].id;
> +	attr->key_size = map_types[n].key_size;
> +	attr->value_size = VAL_SZ;
> +	attr->max_entries = 1;
> +
> +	TEST(bpf(BPF_MAP_CREATE, attr, sizeof(*attr)));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EPERM) {
> +			tst_brk(TCONF | TTERRNO,
> +				"bpf() requires CAP_SYS_ADMIN on this system");
> +		} else {
> +			tst_res(TFAIL | TTERRNO, "Failed to create %s map",
> +				map_types[n].name);
> +			return;
> +		}
> +	}
> +	tst_res(TPASS, "Created %s map", map_types[n].name);
> +	fd = TST_RET;
> +
> +	memset(attr, 0, sizeof(*attr));
> +	attr->map_fd = fd;
> +	attr->key = ptr_to_u64(key);
> +	attr->value = ptr_to_u64(val_get);
> +
> +	TEST(bpf(BPF_MAP_LOOKUP_ELEM, attr, sizeof(*attr)));
> +
> +	switch (n) {

Small nit (maybe personal preference), I'd rather make this check for
map_types.attr, as opposed to test number / some position in array.

> +	case 0:
> +		if (TST_RET != -1 || TST_ERR != ENOENT) {
> +			tst_res(TFAIL | TTERRNO,
> +				"Empty hash map lookup should fail with ENOENT");
> +		} else {
> +			tst_res(TPASS | TTERRNO, "Empty hash map lookup");
> +		}
> +	break;
> +	case 1:
> +		if (TST_RET != -1) {
> +			for (i = 0;;) {
> +				if (val_get[i] != 0) {
> +					tst_res(TFAIL,
> +						"Preallocated array map val not zero");

If we hit this TFAIL, will the loop terminate?

> +				} else if (++i >= VAL_SZ) {
> +					tst_res(TPASS,
> +						"Preallocated array map lookup");
> +					break;
> +				}
> +			}
> +		} else {
> +			tst_res(TFAIL | TERRNO, "Prellocated array map lookup");
> +		}
> +	break;
> +	}
> +
> +	memset(attr, 0, sizeof(*attr));
> +	attr->map_fd = fd;
> +	attr->key = ptr_to_u64(key);
> +	attr->value = ptr_to_u64(val_set);
> +	attr->flags = BPF_ANY;
> +
> +	TEST(bpf(BPF_MAP_UPDATE_ELEM, attr, sizeof(*attr)));
> +	if (TST_RET == -1) {
> +		tst_brk(TFAIL | TTERRNO,
> +			"Update %s map element",
> +			map_types[n].name);
> +	} else {
> +		tst_res(TPASS,
> +			"Update %s map element",
> +			map_types[n].name);
> +	}
> +
> +	memset(attr, 0, sizeof(*attr));
> +	attr->map_fd = fd;
> +	attr->key = ptr_to_u64(key);
> +	attr->value = ptr_to_u64(val_get);
> +
> +	TEST(bpf(BPF_MAP_LOOKUP_ELEM, attr, sizeof(*attr)));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO,
> +			"%s map lookup missing",
> +			map_types[n].name);
> +	} else if (memcmp(val_set, val_get, (size_t) VAL_SZ)) {
> +		tst_res(TFAIL,
> +			"%s map lookup returned different value",
> +			map_types[n].name);
> +	} else {
> +		tst_res(TPASS, "%s map lookup", map_types[n].name);
> +	}
> +
> +	SAFE_CLOSE(fd);
> +}
> +
> +static void setup(void)
> +{
> +	unsigned int i;
> +
> +	memcpy(key8, "12345678", 8);
> +	memset(key4, 0, 4);
> +
> +	for (i = 0; i < VAL_SZ; i++)
> +		val_set[i] = i % 256;
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = 2,

Nit, ARRAY_SIZE(map_types) ?

> +	.test = run,
> +	.setup = setup,
> +	.min_kver = "3.18",
> +	.bufs = (struct tst_buffers []) {
> +		{&key4, .size = 4},
> +		{&key8, .size = 8},
> +		{&val_set, .size = VAL_SZ},
> +		{&val_get, .size = VAL_SZ},
> +		{&attr, .size = sizeof(*attr)},
> +		{},
> +	},
> +};
> --
> 2.21.0
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
