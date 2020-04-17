'use strict';

/**
 * Keranjanguser.js controller
 *
 * @description: A set of functions called "actions" for managing `Keranjanguser`.
 */

module.exports = {

  /**
   * Retrieve keranjanguser records.
   *
   * @return {Object|Array}
   */

  find: async (ctx, next, { populate } = {}) => {
    if (ctx.query._q) {
      return strapi.services.keranjanguser.search(ctx.query);
    } else {
      return strapi.services.keranjanguser.fetchAll(ctx.query, populate);
    }
  },

  /**
   * Retrieve a keranjanguser record.
   *
   * @return {Object}
   */

  findOne: async (ctx) => {
    if (!ctx.params._id.match(/^[0-9a-fA-F]{24}$/)) {
      return ctx.notFound();
    }

    return strapi.services.keranjanguser.fetch(ctx.params);
  },

  /**
   * Count keranjanguser records.
   *
   * @return {Number}
   */

  count: async (ctx) => {
    return strapi.services.keranjanguser.count(ctx.query);
  },

  /**
   * Create a/an keranjanguser record.
   *
   * @return {Object}
   */

  create: async (ctx) => {
    return strapi.services.keranjanguser.add(ctx.request.body);
  },

  /**
   * Update a/an keranjanguser record.
   *
   * @return {Object}
   */

  update: async (ctx, next) => {
    const { produk } = ctx.request.body;
    return strapi.services.keranjanguser.edit(ctx.params, {
      produk: JSON.parse(produk)
    }) ;
  },

  /**
   * Destroy a/an keranjanguser record.
   *
   * @return {Object}
   */

  destroy: async (ctx, next) => {
    return strapi.services.keranjanguser.remove(ctx.params);
  }
};
